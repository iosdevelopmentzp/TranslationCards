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
    
    var dictionaries = BehaviorRelay<[LanguageBind]>.init(value: [])
    
    func bind(addCardPressed plusPressed: ControlEvent<Void>) {
        plusPressed.subscribe() { [weak self] _ in
            self?.services
                .credentials
                .getCurrentUser()
                .subscribe(onNext: { (user) in
                    self?.router.route(to: .createCard(forUserId: user.uid, language: user.currentLanguage))
                }, onError: { (error) in
                    debugPrint("Failed attempt to create new card with error - \(error)")
                    let okAction = AlertModel.ActionModel(title: "Ok",
                                                          style: .destructive,
                                                          handler: nil)
                    let alertModel = AlertModel(actionModels: [okAction],
                                                title: "Failed attempt to create new card with error - \(error.localizedDescription)",
                        message: nil,
                        prefferedStyle: .alert)
                    self?.alertModel.accept(alertModel)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
             }
        .disposed(by: disposeBag)
    }
    
    fileprivate func getDictionaries() -> Observable<[LanguageBind]> {
        return .create { [weak self] (observer) -> Disposable in
            self?.services
                .credentials
                .getCurrentUser()
                .map { (user) -> String in return user.uid }
                .subscribe(onNext: { (userId) in
                    self?.services
                        .cardsService
                        .getLanguageBindsList(forUserWithId: userId)
                        .subscribe(onNext: { (langueges) in
                            observer.onNext(langueges)
                            observer.onCompleted()
                        }, onError: { (error) in
                            observer.onError(error)
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
}
