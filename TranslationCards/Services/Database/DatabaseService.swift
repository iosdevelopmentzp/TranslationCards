//
//  DatabaseService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift

protocol DatabaseService: Service {
    // MARK: - User
    func createUser(_ user: User) -> Observable<Void>
    func updateUser(_ user: User) -> Observable<Void>
    func deleteUser(_ user: User) -> Observable<Void>
    
    // MARK: - Translate cards
    func saveCard(_ card: TranslateCard) -> Observable<Void>
}
