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

class TranslateCard {
    let language: LanguageBind
    fileprivate(set) var userOwnerId: String
    let dateCreated: Date
    var dateUpdated: Date
    fileprivate(set) var sourcePhrase: String
    fileprivate(set) var targetPhrase: String
    var id: String
    
    // if card will save on server need to set this property
    var playlistId: String = "Unknown"
    
    // set true and save, if you want send card to archive
    var isArchived: Bool = false
    
    init(userId: String, language: LanguageBind, sourcePhrase: String, targetPhrase: String) {
        self.userOwnerId = userId
        self.language = language
        self.sourcePhrase = sourcePhrase
        self.targetPhrase = targetPhrase
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
    
    func update(sourcePhrase: String, targetPhrase: String) {
        self.sourcePhrase = sourcePhrase
        self.targetPhrase = targetPhrase
    }
    
    func updateOwnerUserId(newId: String) {
        userOwnerId = newId
    }
}

extension TranslateCard: DataRepresentation {
    var representation: [String : Any] {
        return [
            "userOwnerId" : userOwnerId,
            "dateCreated" : dateCreated.asString,
            "sourcePhrase" : sourcePhrase,
            "targetPhrase" : targetPhrase,
            "dateUpdated" : dateUpdated.asString,
            "language": language.stringRepresentation,
            "id": id
        ]
    }
}
