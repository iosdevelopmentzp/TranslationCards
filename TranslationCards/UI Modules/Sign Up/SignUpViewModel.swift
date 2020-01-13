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
    var signUpTap: PublishSubject<Void> { get }
    var backToLogInTap: PublishSubject<Void> { get }
}

protocol SignUpViewModelOutput {
    var isInputCorrect: BehaviorSubject<Bool> { get }
}

protocol SignUpViewModelType: SignUpViewModelInput & SignUpViewModelOutput {
    var input: SignUpViewModelInput { get }
    var output: SignUpViewModelOutput { get }
}

extension SignUpViewModelType where Self: SignUpViewModelInput & SignUpViewModelOutput {
    var input: SignUpViewModelInput { return self }
    var output: SignUpViewModelOutput { return self }
}

final class SignUpViewModel: ViewModel<SignUpRouter>, SignUpViewModelType, SignUpViewModelInput, SignUpViewModelOutput {
    let logInText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    let displayNameText = PublishSubject<String>()
    let signUpTap = PublishSubject<Void>()
    let backToLogInTap = PublishSubject<Void>()
    let isInputCorrect: BehaviorSubject<Bool> = .init(value: false)
    
    private var inputData: Observable<(String, String, String)> {
        return Observable.combineLatest(logInText.asObserver(), passwordText.asObserver(), displayNameText.asObserver())
    }
    
    override init() {
        super.init()
        
        signUpTap
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (loginText, passwordText, displayName) in
                self?.trySignUp(withEmail: loginText, password: passwordText, displayName: displayName)
            })
            .disposed(by: disposeBag)
        
        inputData
            .map { (login, password, displayName) -> Bool in
                return (login.isEmail && password.count >= 7 && !displayName.isEmpty)}
            .bind(to: isInputCorrect)
            .disposed(by: disposeBag)
        
        backToLogInTap
            .subscribe(onNext: { [weak self] (_) in
                self?.router.comeBack()
            })
            .disposed(by: disposeBag)
        
        services.credentials
            .user
            .unwrap()
            .filter { [weak self] in
                guard $0.nativeLanguage != nil else {
                    self?.router.route(to: .choosingLanguage(user: $0))
                    return false
                }
                return true }
            .ignoreAll()
            .subscribe(onNext: { [weak self] in
                self?.router.route(to: .mainView) })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func trySignUp(withEmail email: String, password: String, displayName: String) {
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
