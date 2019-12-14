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
    fileprivate var user: User?
    
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
    
    func bind(logoutEvent: ControlEvent<Void>) {
        logoutEvent
            .subscribe(onNext: {[weak self] _ in
                self?.services
                    .auth
                    .signOut()
                    .subscribe(onNext: { [weak self] _ in
                        self?.user = nil
                        }, onError: { [weak self] (error) in
                            self?.alertModel.accept(.warningAlert(message: "Failed attempt to sign out. Error \(error)", handler: nil))
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
    }
    
    func bind(addCardPressed plusPressed: ControlEvent<Void>) {
        plusPressed.subscribe(onNext: { [weak self] _ in
            guard let user = self?.user else {
                self?.alertModel.accept(.warningAlert(message: "Failed get user", handler: nil))
                return
            }
            guard let nativeLanguage = user.nativeLanguage else {
                self?.alertModel.accept(.warningAlert(message: "User does not have native language", handler: nil))
                return
            }
            
            let sourceLanguage = user.currentLanguage ?? nativeLanguage.next()
            let languageBind = LanguageBind(source: nativeLanguage, target: sourceLanguage)
            self?.router.route(to: .createCard(forUserId: user.uid, language: languageBind))
        })
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
