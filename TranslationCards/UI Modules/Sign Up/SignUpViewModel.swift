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

protocol SignUpViewModelInput {
    var logInText: PublishSubject<String> { get }
    var passwordText: PublishSubject<String> { get }
    var displayNameText: PublishSubject<String> { get }
    var signUpAction: PublishSubject<Void> { get }
    var backToLogInAction: PublishSubject<Void> { get }
}

protocol SignUpViewModelOutput {
    var isValided: BehaviorSubject<Bool> { get }
}

protocol SignUpViewModelType: SignUpViewModelInput & SignUpViewModelOutput {
    var input: SignUpViewModelInput { get }
    var output: SignUpViewModelOutput { get }
}

extension SignUpViewModelType {
    var input: SignUpViewModelInput { return self }
    var output: SignUpViewModelOutput { return self }
}

final class SignUpViewModel: ViewModel<SignUpRouter>, SignUpViewModelType, SignUpViewModelInput, SignUpViewModelOutput {
    let logInText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    let displayNameText = PublishSubject<String>()
    let signUpAction = PublishSubject<Void>()
    let backToLogInAction = PublishSubject<Void>()
    let isValided: BehaviorSubject<Bool> = .init(value: false)
    
    private var inputData: Observable<(String, String, String)> {
        return Observable.combineLatest(logInText.asObserver(), passwordText.asObserver(), displayNameText.asObserver())
    }
    
    override init() {
        super.init()
        
        signUpAction
        .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (loginText, passwordText, displayName) in
                self?.trySignUp(withEmail: loginText, password: passwordText, displayName: displayName)
            })
        .disposed(by: disposeBag)
        
        inputData
            .map { (login, password, displayName) -> Bool in
                return (login.isEmail && password.count >= 7 && !displayName.isEmpty)}
            .bind(to: isValided)
            .disposed(by: disposeBag)
        
        backToLogInAction
            .subscribe(onNext: { [weak self] (_) in
                self?.router.route(to: .back)
            })
            .disposed(by: disposeBag)
        
        services
            .credentials
            .user
            .subscribe(onNext: { [weak self] (user) in
                guard let user = user else { return}
                guard user.nativeLanguage != nil else {
                    self?.router.route(to: .choiceLanguage(user: user))
                    return
                }
                self?.router.route(to: .mainView) })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func trySignUp(withEmail email: String, password: String, displayName: String) {
        startActivityIndicator.accept(true)
        services
            .auth
            .signUp(withEmail: email, password: password, displayName: displayName)
            .catchError { [weak self] (error) -> Observable<()> in
                self?.errorHandler(description: "Failed attempt sign up", error: error, withAlert: true)
                return .just(()) }
            .map{ false }
            .bind(to: startActivityIndicator)
            .disposed(by: disposeBag)
    }
}
