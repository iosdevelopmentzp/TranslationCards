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
    
    enum Event {
        case nothing
        case removed
        case changed
        case movedToAnotherPlaylist
    }
    
    private(set) var language: LanguageBind
    private(set) var userOwnerId: String
    let dateCreated: Date
    var dateUpdated: Date
    private(set) var sourcePhrase: String
    private(set) var targetPhrase: String
    var id: String
    // if card will save on server need to set this property, using playlist
    private(set) var playlistId: String = "Common"
    
    // Property for observ change of card in real time.
    let runtimeEvents: BehaviorRelay<Event> = .init(value: .nothing)
    
    init(userId: String, language: LanguageBind, sourcePhrase: String, targetPhrase: String) {
        self.userOwnerId = userId
        self.language = language
        self.sourcePhrase = sourcePhrase.trimmingCharacters(in: .whitespaces)
        self.targetPhrase = targetPhrase.trimmingCharacters(in: .whitespaces)
        // Default Initialization
        let currentDate = Date()
        self.dateCreated = currentDate
        self.dateUpdated = currentDate
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
        self.dateUpdated = dateUpdated
        self.sourcePhrase = rootPhrase
        self.targetPhrase = translatePhrase
        self.language = language
        self.id = id
    }
    
    func update(sourcePhrase: String? = nil, targetPhrase: String? = nil) {
        var havePhrasesChanged = false
        if let sourcePhrase = sourcePhrase, sourcePhrase != self.sourcePhrase {
            self.sourcePhrase = sourcePhrase.trimmingCharacters(in: .whitespaces)
            havePhrasesChanged = true
        }
        
        if let targetPhrase = targetPhrase, targetPhrase != self.targetPhrase {
            self.targetPhrase = targetPhrase.trimmingCharacters(in: .whitespaces)
            havePhrasesChanged = true
        }
        if havePhrasesChanged {
            runtimeEvents.accept(.changed)
        }
    }
    
    func updateLanguage(_ newLangugae: LanguageBind) {
        guard newLangugae != self.language else { return }
        self.language = newLangugae
        runtimeEvents.accept(.changed)
    }
    
    func updateOwnerUserId(newId: String) {
        guard newId != userOwnerId else { return }
        userOwnerId = newId
        runtimeEvents.accept(.changed)
    }
    
    func updatePlaylistID(_ newPlaylistID: String) {
        guard newPlaylistID != playlistId else { return }
        playlistId = newPlaylistID
        runtimeEvents.accept(.movedToAnotherPlaylist)
    }
}

extension TranslateCard: DataRepresentation {
    var representation: [String : Any] {
        return [
            "userOwnerId" : userOwnerId,
            "dateCreated" : dateCreated.presentAsString,
            "sourcePhrase" : sourcePhrase,
            "targetPhrase" : targetPhrase,
            "dateUpdated" : dateUpdated.presentAsString,
            "language": language.stringRepresentation,
            "id": id
        ]
    }
}
