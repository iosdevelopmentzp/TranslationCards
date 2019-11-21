//
//  AuthService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift

protocol AuthService: Service {
    var isUserStartedSigIn: BehaviorSubject<Bool> { get }
    func signIn(withEmail email: String, password: String)
    func signUp(withEmail email: String, password: String)
    func signOut() -> Observable<Void>
}
