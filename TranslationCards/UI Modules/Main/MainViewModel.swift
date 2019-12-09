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
    fileprivate var userChangesSubscription: Disposable?
    fileprivate var user: User?
    
    override init() {
        super.init()
        
        services.credentials.user.subscribe(onNext: { [weak self] (user) in
            guard let user = user else {
                self?.userChangesSubscription?.dispose()
                self?.sections.accept([])
                self?.user = nil
                return
            }
            self?.user = user
            self?.makeSubscribesToUser(user)
            
            #if DEBUG
            if user.languages.value.count <= 0 {
                user.appendLanguage(newLanguage: LanguageBind.default,
                                    andCurrentLanguage: LanguageBind.default)
                    .subscribe(onNext: { (_) in
                        debugPrint("Success add user language - \(LanguageBind.default)")
                    }, onError: { [weak self] (error) in
                        let wrongAlert = AlertModel.warningAlert(message: "Failed add user language - with error \(error)", handler: nil)
                        self?.alertModel.accept(wrongAlert)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            }
            #endif
        })
            .disposed(by: disposeBag)
    }
    
    func bind(addCardPressed plusPressed: ControlEvent<Void>) {
        plusPressed.subscribe() { [weak self] _ in
            guard let user = self?.user, let currentLang = user.currentLanguage else {
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
            self?.router.route(to: .createCard(forUserId: user.uid, language: currentLang))
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
    
    fileprivate func makeSubscribesToUser(_ user: User) {
        let subscription = user
            .languages
            .subscribe(onNext: { [weak self] (languages) in
                self?.sections.accept([Section(items: languages)])
            })
        subscription.disposed(by: disposeBag)
    }
}
