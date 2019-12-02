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
    
    enum OwnError: Error {
        case userNotFoundUserEqualNill
        
        var localizedDescription: String {
            switch self {
            case .userNotFoundUserEqualNill:
                return "User not found. User == nil"
            }
        }
    }
    
    var user: BehaviorRelay<User?> = BehaviorRelay.init(value: nil)
    private var database: DatabaseService
    
    init(database: DatabaseService) {
        self.database = database
    }
    
    func editUser() -> Observable<Void> {
        return .empty()
    }
    
    func getCurrentUser() -> Observable<User> {
        Observable<User>.create { [weak self] (observer) -> Disposable in
            if let user = self?.user.value {
                observer.onNext(user)
                observer.onCompleted()
            } else {
                observer.onError(OwnError.userNotFoundUserEqualNill)
            }
            return Disposables.create()
        }
    }
}
