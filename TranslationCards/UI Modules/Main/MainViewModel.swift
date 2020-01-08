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
        
        self.user = User.currentUser.value
        
        self.startActivityIndicator.accept(true)
        self.user?
            .fetchLanguages()
            .subscribe(onNext: { [weak self](_) in
                self?.startActivityIndicator.accept(false)
            }, onError: { [weak self] (error) in
                self?.startActivityIndicator.accept(false)
                self?.errorHandler(description: "Failed get languages", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
        
        
        self.user?
            .languages
            .subscribe(onNext: { [weak self] (languages) in
                guard let languages = languages else { return }
                let section = Section(items: languages)
                self?.sections.accept([section])
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
                            self?.errorHandler(description: "Failed attempt to sign out.", error: error, withAlert: true)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
    }
    
    func bindSelectesItemEvent(_ selectedEvent: ControlEvent<IndexPath>) {
        selectedEvent
            .subscribe(onNext: {[weak self] (indexPath) in
                guard let language = self?.sections.value[indexPath.section].items[indexPath.row],
                    let user = self?.user else { return }
                self?.router.route(to: .cardList(language: language, user: user))
            })
            .disposed(by: disposeBag)
    }
}
