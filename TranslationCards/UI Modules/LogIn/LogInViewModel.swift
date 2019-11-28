//
//  LogInViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LogInViewModel: ViewModel<LogInRouter> {
    
    var isValideText: BehaviorRelay<Bool> = BehaviorRelay.init(value: false)
    
    // MARK: - Public methods
    func bind(withLogin login: ControlProperty<String?>,
              withPassword password: ControlProperty<String?>,
              didPressButton: ControlEvent<Void>) {
        
        // prevent spaces
        [login, password].forEach {
            $0.orEmpty
                .map { $0.components(separatedBy: .whitespaces).joined() }
                .bind(to: $0)
                .disposed(by: disposeBag)
        }
        
        // sig in action
        let userInputs = Observable.combineLatest(login.orEmpty, password.orEmpty)
        didPressButton
            .withLatestFrom(userInputs)
            .subscribe(onNext: { [weak self] (login, password) in
                // TODO: Start activity indicator
                self?.services.auth.signIn(withEmail: login, password: password)
                    .subscribe(onNext: { (_) in
                        // TODO: - Finish activity indicator animating
                    }, onError: { (error) in
                        // TODO: - Make error alert and finish activity indicator
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
        
        // validate input
        userInputs
            .map { (login, password) -> Bool in
                return (login.isEmail && (password.count >= 7))}
            .bind(to: isValideText)
            .disposed(by: disposeBag)
    }
    
    func bind(didPressSignUpButton: ControlEvent<Void>) {
        didPressSignUpButton
            .subscribe(onNext: { [weak self] in
                self?.router.route(to: .signUp)
            })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Override
    override func bindWithServices() {
        super.bindWithServices()
        services
            .credentials
            .user
            .subscribe(onNext: { [weak self] (user) in
                guard user != nil else { return}
                self?.router.route(to: .mainNavigation) })
            .disposed(by: disposeBag)
    }
}
