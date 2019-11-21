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

    var user: BehaviorRelay<User?> = BehaviorRelay.init(value: nil)
    private var database: DatabaseService
    
    init(database: DatabaseService) {
        self.database = database
    }
    
    func editUser() -> Observable<Void> {
        return .empty()
    }
    
    
}
