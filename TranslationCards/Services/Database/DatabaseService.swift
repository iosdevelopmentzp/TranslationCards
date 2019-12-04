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
    func fetchUser(withUserId userId: String) -> Observable<User?>
    func updateUser(withUserId userId: String, withData data: [String: Any]) -> Observable<Void>
    func deleteUser(_ user: User) -> Observable<Void>
    
    // MARK: - Translate cards
    func saveCard(_ card: TranslateCard) -> Observable<Void>
    func appendNewLanguage(_ language: LanguageBind, currentLanguage: LanguageBind, forUser user: User) -> Observable<Void>
    func getLanguageList(forUserId userId: String) -> Observable<[LanguageBind]>
    func getCards(withLanguage language: LanguageBind, userId: String) -> Observable<[TranslateCard]>
}
