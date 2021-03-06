//
//  CredentialsService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxRelay

protocol CredentialsService: Service {
    var user: BehaviorRelay<User?> { get }
    func acceptUser()
    func fetchRemoteUser(withId userId: String) -> Observable<Void>
    func getUser(withId userId: String) -> Observable<User>
}
