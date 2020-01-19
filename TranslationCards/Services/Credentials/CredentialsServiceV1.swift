//
//  CredentialsServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxRelay

final class CredentialsServiceV1: NSObject, CredentialsService {
    
    var user: BehaviorRelay<User?>
    private let databaseService: DatabaseService
    private let keyStorageService: KeyValueStorageService
    private let dataCoordinatorService: DataCoordinator
    private let listenerService: ListenerService
    private var disposeBag = DisposeBag()
    
    init(database: DatabaseService, keyStorage: KeyValueStorageService, dataCoordinator: DataCoordinator, listenerService: ListenerService) {
        self.databaseService = database
        self.keyStorageService = keyStorage
        self.dataCoordinatorService = dataCoordinator
        self.listenerService = listenerService
        
        if let userData: [String: Any] = try? keyStorage.value(forKey: KeyStorage.userDataKey),
            let user = User(withData: userData) {
            self.user = .init(value: user)
        } else {
            self.user = .init(value: nil)
        }
        super.init()

        user.subscribe(onNext: { [weak self] (user) in
                self?.updateUserKeyStorage(withUser: user)})
            .disposed(by: disposeBag)
        
        startUserObserving()
        
        if let user = self.user.value {
            dataCoordinator
                .synchronizeUserWithRemote(user)
                .subscribe(onError: { [weak self] (error) in
                    debugPrint("Failed update user with Remote data - \(error)")
                    self?.user.accept(nil)
                })
                .disposed(by: disposeBag)
        }
    }
    
    func acceptUser() {
        user.accept(user.value)
    }
    
    func fetchRemoteUser(withId userId: String) -> Observable<Void> {
        databaseService
            .fetchUser(withUserId: userId)
            .execute({ [weak self] (user) in
                self?.user.accept(user)
            })
            .flatMap({ (_) -> Observable<Void> in
                return .just(())
            })
            .catchError({ [weak self] (error) -> Observable<Void> in
                debugPrint("Failed fetch remote user, with error \(error)")
                self?.user.accept(nil)
                return .error(error)
            })
    }
    
    func getUser(withId userId: String) -> Observable<User> {
        if let user = user.value, user.uid == userId {
            return .just(user)
        }
        return databaseService.fetchUser(withUserId: userId)
    }
    
    // MARK: - Private
    private func startUserObserving() {
        listenerService
            .userСhangesListener
            .withLatestFrom(user) {($0, $1)}
            .filter{ $0.userId == $1?.uid}
            .subscribe(onNext: { [weak self] (changes, user) in
                self?.updateUserKeyStorage(withUser: user)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUserKeyStorage(withUser user: User?) {
        guard let user = user else {
            keyStorageService.deleteValue(forKey: KeyStorage.userDataKey)
            return
        }
        keyStorageService.setValue(user.representation, forKey: KeyStorage.userDataKey)
    }
}
