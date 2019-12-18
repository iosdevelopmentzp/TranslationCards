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

enum LearningLevel: Int {
    case low = 0
    case middle
    case high
    case highest
}

class TranslateCard {
    let language: LanguageBind
    let userOwnerId: String
    let dateCreated: Date
    var dateUpdated: Date
    fileprivate(set) var sourcePhrase: String
    fileprivate(set) var targetPhrase: String
    var numberGuesses: Int
    var numberrAttempts: Int
    var learningLevel: LearningLevel
    var id: String
    
    init(userId: String, language: LanguageBind, sourcePhrase: String, targetPhrase: String) {
        self.userOwnerId = userId
        self.language = language
        self.sourcePhrase = sourcePhrase
        self.targetPhrase = targetPhrase
        // Default Initialization
        let currentDate = Date()
        self.dateCreated = currentDate
        self.dateUpdated = currentDate
        self.numberGuesses = 0
        self.numberrAttempts = 0
        self.learningLevel = .low
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
            let numberGuesses = data["numberGuesses"] as? Int,
            let numberrAttempts = data["numberrAttempts"] as? Int,
            let learningLevelInt = data["learningLevel"] as? Int,
            let learningLevel = LearningLevel(rawValue: learningLevelInt),
            let languageString = data["language"] as? String,
            let language = LanguageBind(withString: languageString),
            let id = data["id"] as? String
        else { return nil }
        
        self.userOwnerId = userOwnerId
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.sourcePhrase = rootPhrase
        self.targetPhrase = translatePhrase
        self.numberGuesses = numberGuesses
        self.numberrAttempts = numberrAttempts
        self.learningLevel = learningLevel
        self.language = language
        self.id = id
    }
}

extension TranslateCard: DatabaseServiceAccessing {
    func update(sourcePhrase: String, targetPhrase: String) -> Observable<Void> {
        self.sourcePhrase = sourcePhrase
        self.targetPhrase = targetPhrase
        return database.saveCard(self)
    }
    
    func save() -> Observable<Void> {
        database.saveCard(self)
    }
    
    func remove() -> Observable<Void> {
        database.removeCard(self)
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
            "numberGuesses" : numberGuesses,
            "numberrAttempts" : numberrAttempts,
            "learningLevel" : learningLevel.rawValue,
            "language": language.stringRepresentation,
            "id": id
        ]
    }
}
