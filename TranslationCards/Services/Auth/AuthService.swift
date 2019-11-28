//
//  AuthService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift

protocol AuthService: Service {
    func signIn(withEmail email: String, password: String) -> Observable<Void>
    func signUp(withEmail email: String, password: String, displayName: String) -> Observable<Void>
    func signOut() -> Observable<Void>
}
