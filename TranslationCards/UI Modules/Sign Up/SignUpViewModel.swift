//
//  SignUpViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel: ViewModel<SignUpRouter> {
    
    var isValided = BehaviorSubject<Bool>.init(value: false)
    var isActivityAnimate = BehaviorSubject<Bool>.init(value: false)
    
    fileprivate var loginName = BehaviorSubject<String>.init(value: "")
    fileprivate var password = BehaviorSubject<String>.init(value: "")
    fileprivate var displayName = BehaviorSubject<String>.init(value: "")
    
    func bind(withTextFields textFields: [(RegisterCardView.FieldType, TextFieldWithTopPlaceholder)], signUpPressedEvent signUpEvent: ControlEvent<Void>) {
        textFields.forEach {
            switch $0 {
            case .email:
                $1.inputText
                    .bind(to: loginName)
                    .disposed(by: disposeBag)
                $1.textField
                    .preventSpaces(disposeBag: disposeBag)
            case .password:
                $1.inputText
                    .bind(to: password)
                    .disposed(by: disposeBag)
                $1.textField
                    .preventSpaces(disposeBag: disposeBag)
            case .displayName:
                $1.inputText
                    .bind(to: displayName)
                    .disposed(by: disposeBag)
            }
        }
        
        let commonObservable = Observable.combineLatest(loginName, password, displayName)
        
        commonObservable
            .map { (loginName, password, displayName) -> Bool in
                return (loginName.isEmail && password.count > 6 && !displayName.isEmpty) }
            .distinctUntilChanged()
            .bind(to: isValided)
            .disposed(by: disposeBag)
        
        signUpEvent
            .withLatestFrom(commonObservable)
            .subscribe(onNext: { [weak self] (login, password, displayName) in
                self?.isActivityAnimate.onNext(true)
                self?.services.auth.signUp(withEmail: login,
                                           password: password,
                                           displayName: displayName)
                    .subscribe(onNext: {
                        self?.isActivityAnimate.onNext(false)
                    }, onError: { (error) in
                        self?.isActivityAnimate.onNext(false)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
    }
    
    func pressedLogInButton() {
        router.route(to: .back)
    }
}
