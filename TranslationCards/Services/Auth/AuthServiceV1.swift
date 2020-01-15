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
            .withLatestFrom(Observable.just(credentials)) {($0, $1)}
            .flatMap { (result, credentials) -> Observable<Void> in
                return credentials.fetchRemoteUser(withId: result.user.uid) }
    }
    
    func signUp(withEmail email: String, password: String, displayName: String) -> Observable<Void> {
        return auth.rx
            .createUser(withEmail: email, password: password)
            .map{ User(uid: $0.user.uid,
                       email: $0.user.email,
                       username: displayName,
                       avatarUrl: $0.user.photoURL?.absoluteString) }
            .withLatestFrom(Observable.just(database)) {($0, $1)}
            .flatMap { user, database -> Observable<User> in
                return database.createUser(user).map{ user } }
            .withLatestFrom(Observable.just(credentials)) {($0, $1)}
            .flatMap{ user, credentials -> Observable<Void> in
                return credentials.fetchRemoteUser(withId: user.uid) }
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
