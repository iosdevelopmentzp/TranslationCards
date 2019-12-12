//
//  MainViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModel<MainRouter> {
    
    var sections = BehaviorRelay<[Section]>.init(value: [])
    fileprivate weak var user: User?
    
    override init() {
        super.init()
        
        guard let user = services.credentials.user.value else {
            alertModel.accept(.warningAlert(message: "Failed get current user.", handler: nil))
            return
        }
        
        self.user = user
        services
            .listener
            .listenLanguageBindList(forUserWithId: user.uid)
            .subscribe(onNext: { [weak self] (changed) in
                self?.proccessDocumentChanges(changed)
                }, onError: { [weak self] (error) in
                    self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: nil))
                })
            .disposed(by: disposeBag)
    }
    
    func bind(addCardPressed plusPressed: ControlEvent<Void>) {
        plusPressed.subscribe() { [weak self] _ in
            guard let user = self?.user else {
                    let okAction = AlertModel.ActionModel(title: "Ok",
                                                          style: .destructive,
                                                          handler: nil)
                    let alertModel = AlertModel(actionModels: [okAction],
                                                title: "Something went wrong",
                                                message: "User does not have current language",
                                                prefferedStyle: .alert)
                    self?.alertModel.accept(alertModel)
                    return
            }
            let sourceLanguage = user.currentLanguage ?? user.nativeLanguage.next()
            let languageBind = LanguageBind(source: user.nativeLanguage, target: sourceLanguage)
            self?.router.route(to: .createCard(forUserId: user.uid, language: languageBind))
        }
        .disposed(by: disposeBag)
    }
    
    func bindSelectesItemEvent(_ selectedEvent: ControlEvent<IndexPath>) {
        selectedEvent
            .subscribe(onNext: {[weak self] (indexPath) in
                guard let language = self?.sections.value[indexPath.section].items[indexPath.row],
                    let user = self?.user else { return }
                self?.router.route(to: .cardList(language: language, userId: user.uid))
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func proccessDocumentChanges(_ documentChanges: ChangedDocuments<LanguageBind>) {
        guard var itemsForChange = sections.value.first?.items else {
            if documentChanges.type == .added {
                sections.accept([Section(items: documentChanges.changedObjects)])
            }
            return
        }
        
        switch documentChanges.type {
        case .added:
            documentChanges.changedObjects.forEach {
                itemsForChange.append($0)
            }
        case .modified:
            break
        case .removed:
            documentChanges.changedObjects.forEach {
                guard let index = itemsForChange.firstIndex(of: $0) else { return }
                itemsForChange.remove(at: index)
            }
        }
        sections.accept([Section(items: itemsForChange)])
    }
}
