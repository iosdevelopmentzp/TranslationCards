//
//  Card.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 29.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class TranslateCard {
    
    private(set) var language: BehaviorRelay<LanguageBind>
    private(set) var userOwnerId: String
    let dateCreated: Date
    var dateUpdated: BehaviorRelay<Date>
    private(set) var sourcePhrase: BehaviorRelay<String>
    private(set) var targetPhrase: BehaviorRelay<String>
    private(set) var id: String
    // When saving a card to the database, update the name of the playlist to identify which playlist to put the card in
    private(set) var playlistId: BehaviorRelay<String> = .init(value: "")
    
    init(userId: String, language: LanguageBind, sourcePhrase: String, targetPhrase: String) {
        self.userOwnerId = userId
        self.language = .init(value: language)
        self.sourcePhrase = .init(value: sourcePhrase.trimmingCharacters(in: .whitespaces))
        self.targetPhrase = .init(value: targetPhrase.trimmingCharacters(in: .whitespaces))
        // Default Initialization
        let currentDate = Date()
        self.dateCreated = currentDate
        self.dateUpdated = .init(value: currentDate)
        self.id = UUID().uuidString
    }
    
    required init?(withData data: [String: Any]) {
        guard let userOwnerId = data["userOwnerId"] as? String,
            let dateCreatedString = data["dateCreated"] as? String,
            let dateCreated = Date.initWithString(dateCreatedString),
            let dateUpdatedString = data["dateUpdated"] as? String,
            let dateUpdated = Date.initWithString(dateUpdatedString),
            let rootPhrase = data["sourcePhrase"] as? String,
            let translatePhrase = data["targetPhrase"] as? String,
            let languageString = data["language"] as? String,
            let language = LanguageBind(withString: languageString),
            let id = data["id"] as? String
        else { return nil }
        
        self.userOwnerId = userOwnerId
        self.dateCreated = dateCreated
        self.dateUpdated = .init(value: dateUpdated)
        self.sourcePhrase = .init(value: rootPhrase)
        self.targetPhrase = .init(value: translatePhrase)
        self.language = .init(value: language)
        self.id = id
    }
    
    func update(sourcePhrase: String? = nil, targetPhrase: String? = nil) {
        if let sourcePhrase = sourcePhrase, sourcePhrase != self.sourcePhrase.value {
            self.sourcePhrase.accept(sourcePhrase.trimmingCharacters(in: .whitespaces))
        }
        
        if let targetPhrase = targetPhrase, targetPhrase != self.targetPhrase.value {
            self.targetPhrase.accept(targetPhrase.trimmingCharacters(in: .whitespaces))
        }
    }
    
    func updateLanguage(_ newLangugae: LanguageBind) {
        guard newLangugae != self.language.value else { return }
        self.language.accept(newLangugae)
    }
    
    func updateOwnerUserId(newId: String) {
        guard newId != userOwnerId else { return }
        userOwnerId = newId
    }
    
    func updatePlaylistID(_ newPlaylistID: String) {
        guard newPlaylistID != playlistId.value else { return }
        playlistId.accept(newPlaylistID)
    }
    
    func updateId(_ newId: String) {
        self.id = newId
    }
}

extension TranslateCard: DataRepresentation {
    var representation: [String : Any] {
        return [
            "userOwnerId" : userOwnerId,
            "dateCreated" : dateCreated.presentAsString,
            "sourcePhrase" : sourcePhrase.value,
            "targetPhrase" : targetPhrase.value,
            "dateUpdated" : dateUpdated.value.presentAsString,
            "language": language.value.stringRepresentation,
            "id": id
        ]
    }
}

extension TranslateCard: CustomStringConvertible {
    var description: String {
        return "Card (\(id)):::::: language - \(language.value) ::::: source phrase - \"\(sourcePhrase.value)\" :::::: target phrase - \"\(targetPhrase.value)\" :::::: playlistId - \(playlistId.value) :::::: userOwnerId - \(userOwnerId)"
    }
}
