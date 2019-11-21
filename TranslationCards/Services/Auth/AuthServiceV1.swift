//
//  AuthServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxFirebase
import Firebase

private enum Error: ServiceError {
    case userDoesNotExist(withEmail: String)
    case userDidNotSignOut(Swift.Error)
    case some(Swift.Error)
    
    var serviceName: String { return "AuthService"}
    var description: String {
        switch self {
        case .userDoesNotExist(withEmail: let email):
            return "User with email \"\(email)\" does not exist"
        case .some(let error):
            return error.localizedDescription
        case .userDidNotSignOut(let error):
            return "User did not sign out. Error - \(error)"
        }
    }
}

class AuthServiceV1: NSObject, AuthService {
    private let disposeBag = DisposeBag()
    private var credentials: CredentialsService
    private var database: DatabaseService
    private let auth = Auth.auth()
    
    var isUserStartedSigIn: BehaviorSubject<Bool> = BehaviorSubject.init(value: false)
    
    init(credentials: CredentialsService, database: DatabaseService) {
        self.credentials = credentials
        self.database = database
    }
    
    func signIn(withEmail email: String, password: String) {
        isUserStartedSigIn.onNext(true)
        auth
            .rx
            .signIn(withEmail: email, password: password)
            .subscribe(onNext: { [weak self] (result) in
                let user = User(uid: result.user.uid,
                                email: result.user.email,
                                username: nil,
                                avatarUrl: result.user.photoURL?.absoluteString)
                self?.credentials.user.accept(user)
                }, onError: { [weak self] (error) in
                    debugPrint(error.localizedDescription)
                    self?.isUserStartedSigIn.onNext(false)
                }, onCompleted: { [weak self] in
                    self?.isUserStartedSigIn.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    func signUp(withEmail email: String, password: String) {
        auth
            .rx
            .createUser(withEmail: email, password: password)
            .subscribe(onNext: { [weak self] (result) in
                let user = User(uid: result.user.uid,
                                email: result.user.email,
                                username: nil,
                                avatarUrl: result.user.photoURL?.absoluteString)
                self?.credentials.user.accept(user)
                }, onError: { (error) in
                    debugPrint(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func signOut() -> Observable<Void> {
        do {
            try auth.signOut()
            return .empty()
        } catch {
            return .error(error)
        }
    }
}
