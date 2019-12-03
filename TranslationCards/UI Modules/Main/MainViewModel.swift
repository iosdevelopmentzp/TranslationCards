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
    
    fileprivate func makeSubscribesToUser(_ user: User) {
        let subscription = user.languages
            .subscribe(onNext: { [weak self] (languages) in
                let items = languages.map{ $0.stringRepresentation}
                self?.sections.accept([Section(items: items)])
            })
        subscription.disposed(by: disposeBag)
    }
}