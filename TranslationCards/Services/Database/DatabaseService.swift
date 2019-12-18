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
    func moveCardFromArchive(_ card: TranslateCard) -> Observable<Void>
    func moveCardToArchive(_ card: TranslateCard) -> Observable<Void>
    func removeCard(_ card: TranslateCard) -> Observable<Void>
    func saveCard(_ card: TranslateCard, cardLanguageIsCurrentLanguage isCurrentLanguage: Bool) -> Observable<Void>
    func getLanguageList(forUserId userId: String) -> Observable<[LanguageBind]>
    func getCards(withLanguage language: LanguageBind, userId: String) -> Observable<[TranslateCard]>
    func getArchivedCards(withLanguage language: LanguageBind, userId: String) -> Observable<[TranslateCard]>
}

extension DatabaseService {
    func saveCard(_ card: TranslateCard, cardLanguageIsCurrentLanguage isCurrentLanguage: Bool = false) -> Observable<Void> {
        var isCurrentLanguage = false
        if let user = Services.shared.credentials.user.value, user.uid == card.userOwnerId {
            if let currentLanguage = user.currentLanguage {
                isCurrentLanguage = currentLanguage != card.language.targetLanguage
            } else {
                isCurrentLanguage = true
            }
        }
        return saveCard(card, cardLanguageIsCurrentLanguage: isCurrentLanguage)
    }
}
