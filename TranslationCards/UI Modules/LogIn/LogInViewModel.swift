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
    var logInText: PublishSubject<String> { get set}
    var passwordText: PublishSubject<String> { get set }
    var logInAction: PublishSubject<Void> { get set }
    var signUpAction: PublishSubject<Void> { get set}
}
protocol LogInViewModelOutput {
    var isValidetText: BehaviorRelay<Bool> { get set}
}
protocol LogInViewModelType: LogInViewModelInput & LogInViewModelOutput {
    var input: LogInViewModelInput { get }
    var output: LogInViewModelOutput { get }
}

extension LogInViewModelType {
    var input: LogInViewModelInput { return self}
    var output: LogInViewModelOutput { return self}
}

final class LogInViewModel: ViewModel<LogInRouter>, LogInViewModelInput, LogInViewModelOutput, LogInViewModelType {
    
    var logInAction = PublishSubject<Void>()
    var logInText = PublishSubject<String>()
    var passwordText = PublishSubject<String>()
    var signUpAction = PublishSubject<Void>()
    var isValidetText = BehaviorRelay<Bool>.init(value: false)
    
    private var inputData: Observable<(String, String)> {
        return Observable.combineLatest(logInText.asObserver(), passwordText.asObserver())
    }

    override init() {
        super.init()
        
        logInAction
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (login, password) in
                self?.tryToSignIn(login: login, password: password)
            })
            .disposed(by: disposeBag)
 
        inputData
            .map { (login, password) -> Bool in
                return (login.isEmail && (password.count >= 7))}
            .bind(to: isValidetText)
            .disposed(by: disposeBag)
        
        signUpAction
            .subscribe(onNext: { [weak self] (_) in
                self?.router.route(to: .signUp)
            })
            .disposed(by: disposeBag)
        
        services
            .credentials
            .user
            .subscribe(onNext: { [weak self] (user) in
                guard let user = user else { return}
                guard user.nativeLanguage != nil else {
                    self?.router.route(to: .choiceLanguage)
                    return
                }
                self?.router.route(to: .mainView) })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func tryToSignIn(login: String, password: String) {
        self.startActivityIndicator.accept(true)
        self.services
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
