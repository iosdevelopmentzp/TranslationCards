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
        Observable<Void>.create { [weak self] (observer) -> Disposable in
            self?.auth
                .rx
                .signIn(withEmail: email, password: password)
                .subscribe(onNext: { [weak self] (result) in
                    
                    self?.database
                        .fetchUser(withUserId: result.user.uid)
                        .subscribe(onNext: { (user) in
                            self?.credentials.user.accept(user)
                            observer.onNext(())
                            observer.onCompleted()
                        }, onError: { (error) in
                            observer.onError(error)
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                    
                    observer.onNext(())
                    }, onError: { (error) in
                        debugPrint(error.localizedDescription)
                        observer.onError(error)
                }).disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    func signUp(withEmail email: String, password: String, displayName: String) -> Observable<Void> {
        Observable<Void>.create { [weak self] (observer) -> Disposable in
            self?.auth
                .rx
                .createUser(withEmail: email, password: password)
                .subscribe(onNext: { [weak self] (result) in
                    let user = User(uid: result.user.uid,
                                    email: result.user.email,
                                    username: displayName,
                                    avatarUrl: result.user.photoURL?.absoluteString)
                    self?.database.createUser(user)
                        .subscribe(onNext: {
                            self?.credentials.user.accept(user)
                            observer.onNext(())
                        }, onError: { (error) in
                            observer.onError(error)
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                    }, onError: { (error) in
                        debugPrint(error.localizedDescription)
                        observer.onError(error)
                }).disposed(by: self?.disposeBag ?? DisposeBag() )
            
            return Disposables.create()
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
    
    enum AuthServiceError: Error {
        case failedFetchUserFromDataBase
    }
}
