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

protocol LogInViewModelInput {
    var logInText: PublishSubject<String> { get}
    var passwordText: PublishSubject<String> { get }
    var logInTap: PublishSubject<Void> { get }
    var signUpTap: PublishSubject<Void> { get }
}
protocol LogInViewModelOutput {
    var isInputCorrect: BehaviorRelay<Bool> { get }
}
protocol LogInViewModelType: LogInViewModelInput & LogInViewModelOutput {
    var input: LogInViewModelInput { get }
    var output: LogInViewModelOutput { get }
}

extension LogInViewModelType where Self: LogInViewModelOutput & LogInViewModelInput {
    var input: LogInViewModelInput { return self}
    var output: LogInViewModelOutput { return self}
}

final class LogInViewModel: ViewModel<LogInRouter>, LogInViewModelType, LogInViewModelOutput, LogInViewModelInput  {
    
    let logInTap = PublishSubject<Void>()
    let logInText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    let signUpTap = PublishSubject<Void>()
    let isInputCorrect = BehaviorRelay<Bool>.init(value: false)
    
    private var inputData: Observable<(String, String)> {
        return Observable.combineLatest(logInText.asObserver(), passwordText.asObserver())
    }

    override init() {
        super.init()
        
        logInTap
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (login, password) in
                self?.tryToSignIn(login: login, password: password)
            })
            .disposed(by: disposeBag)
 
        inputData
            .map { (login, password) -> Bool in
                return (login.isEmail && (password.count >= 7))}
            .bind(to: isInputCorrect)
            .disposed(by: disposeBag)
        
        signUpTap
            .subscribe(onNext: { [weak self] (_) in
                self?.router.route(to: .signUp)
            })
            .disposed(by: disposeBag)
        
        services.credentials
            .user
            .unwrap()
            .filter { [weak self] in
                guard $0.nativeLanguage != nil else {
                    self?.router.route(to: .tyrRouteToChoosingLanguage(user: $0))
                    return false
                }
                return true }
            .subscribe(onNext: { [weak self] (user) in
                self?.router.route(to: .tryRouteToMainView) })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func tryToSignIn(login: String, password: String) {
        self.startActivityIndicator.accept(true)
        services
            .auth
            .signIn(withEmail: login, password: password)
            .catchError { [weak self] (error) -> Observable<()> in
                self?.errorHandler(description: "Failed attempt to Sign In", error: error, withAlert: true)
                return .just(()) }
            .map{ false }
            .bind(to: self.startActivityIndicator)
            .disposed(by: disposeBag)
    }
}
