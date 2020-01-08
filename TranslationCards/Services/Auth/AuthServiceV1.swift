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

final class AuthServiceV1: NSObject, AuthService {
    private let disposeBag = DisposeBag()
    private var credentials: CredentialsService
    private var database: DatabaseService
    private let auth = Auth.auth()
    
    init(credentials: CredentialsService, database: DatabaseService) {
        self.credentials = credentials
        self.database = database
    }
    
    func signIn(withEmail email: String, password: String) -> Observable<Void> {
        return auth.rx
            .signIn(withEmail: email, password: password)
            .flatMap { [weak self] (result) -> Observable<Void> in
                return self?.credentials.fetchRemoteUser(withId: result.user.uid) ?? .just(()) }
    }
    
    func signUp(withEmail email: String, password: String, displayName: String) -> Observable<Void> {
        var userId: String?
        return auth.rx
            .createUser(withEmail: email, password: password)
            .map{ User(uid: $0.user.uid,
                       email: $0.user.email,
                       username: displayName,
                       avatarUrl: $0.user.photoURL?.absoluteString) }
            .flatMap { [weak self] user -> Observable<User> in
                userId = user.uid
                let createUserObserver = self?.database.createUser(user).map{ user }
                return createUserObserver ?? .just(user) }
            .flatMap{ [weak self] user -> Observable<Void> in
                return self?.credentials.fetchRemoteUser(withId: user.uid) ?? .just(()) }
            .catchError { [weak self] (errorSignUpUser) -> Observable<()> in
                guard let userId = userId, let user = self?.auth.currentUser, userId == user.uid else {
                    return .error(errorSignUpUser)
                }
                return .create { [weak self] (observer) -> Disposable in
                    guard let self = self else {
                        observer.onNext(())
                        observer.onCompleted()
                        return Disposables.create() }
                    self.auth.currentUser?.delete(completion: { (errorDeleteUser) in
                        if let error = errorDeleteUser {
                            observer.onError(error)
                        } else {
                            observer.onError(errorSignUpUser)
                        }
                    })
                    return Disposables.create()
                }
        }
    }
    
    func signOut() -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            do {
                try self?.auth.signOut()
                self?.credentials.user.accept(nil)
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
