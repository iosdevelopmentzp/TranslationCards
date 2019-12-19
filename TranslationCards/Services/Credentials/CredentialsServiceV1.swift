//
//  CredentialsServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxRelay

class CredentialsServiceV1: NSObject, CredentialsService {
    
    var user: BehaviorRelay<User?>
    private var database: DatabaseService
    private var keyStorage: KeyValueStorageService
    private var disposeBag = DisposeBag()
    
    init(database: DatabaseService, keyStorage: KeyValueStorageService) {
        self.database = database
        self.keyStorage = keyStorage
        
        if let userData: [String: Any] = try? keyStorage.value(forKey: KeyStorage.userDataKey),
            let user = User(withData: userData) {
            self.user = .init(value: user)
        } else {
            self.user = .init(value: nil)
        }
        super.init()
        
        if let user = self.user.value {
            user.synchronizeWithRemote()
        }
        
        user.subscribe(onNext: { [weak self] (user) in
                guard let user = user else {
                    self?.keyStorage.deleteValue(forKey: KeyStorage.userDataKey)
                    return
                }
                self?.keyStorage.setValue(user.representation, forKey: KeyStorage.userDataKey) })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func fetchRemoteUser(withId userId: String) {
        database
            .fetchUser(withUserId: userId)
            .subscribe(onNext: { [weak self] (user) in
                self?.user.accept(user)
                }, onError: { [weak self] (error) in
                    debugPrint("Failed fetch remote user, with error \(error)")
                    self?.user.accept(nil)
            })
            .disposed(by: disposeBag)
    }
}
