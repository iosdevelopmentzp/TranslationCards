//
//  Playlist.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 19.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

class Playlist: Equatable, Hashable {
    let name: String
    let dateCreated: Date
    let numberOfCards: Int
    let userOwnerId: String
    let language: LanguageBind
    var id: String { return name }
    
    // MARK: - Buffer properties
    
    init(name: String, dateCreated: Date, userOwnerId: String, language: LanguageBind) {
        self.name = name
        self.dateCreated = dateCreated
        self.userOwnerId = userOwnerId
        self.language = language
        self.numberOfCards = 0
    }
    
    required init?(withData data: [String : Any]) {
        guard let name = data["name"] as? String,
            let dateCreatedString = data["dateCreated"] as? String,
            let date = Date.initWithString(dateCreatedString),
            let numberOfCards = data["numberOfCards"] as? Int,
            let userOwnerId = data["userOwnerId"] as? String,
            let languageString = data["language"] as? String,
            let language = LanguageBind(withString: languageString) else {
                return nil
        }
        self.name = name
        self.dateCreated = date
        self.numberOfCards = numberOfCards
        self.userOwnerId = userOwnerId
        self.language = language
    }
    
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.name == rhs.name && lhs.userOwnerId == rhs.userOwnerId && lhs.language == rhs.language
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(userOwnerId)
        hasher.combine(language)
    }
}

extension Playlist: CustomStringConvertible {
    var description: String {
        return "Playlist: userId: \(userOwnerId), \(language.id), name: \(name)"
    }
}

extension Playlist: DataRepresentation {
    var representation: [String : Any] {
        return [
            "name": name,
            "userOwnerId": userOwnerId,
            "dateCreated": dateCreated.asString,
            "numberOfCards": numberOfCards,
            "language": language.stringRepresentation
        ]
    }
}
