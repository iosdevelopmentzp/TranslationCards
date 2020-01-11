//
//  LanguageBind.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 30.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

struct LanguageBind: Equatable, Decodable {
    let sourceLanguage: Language
    let targetLanguage: Language
    var id: String { return stringRepresentation }
    private static let k_separator = "_"
    
    /// sourceLanguage and targetLanguage should not be the same
    init(source sourceLanguage: Language, target targetLanguage: Language) {
        guard sourceLanguage != targetLanguage else {
            fatalError("Attempt create LanguageBind with the same languages")
        }
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
    }
    
    init?(withString string: String) {
        let components = string.components(separatedBy: LanguageBind.k_separator)
        guard components.count == 2,
            let sourceLanguage = Language(rawValue: components[0]),
            let targetLanguage = Language(rawValue: components[1]) else {
            return nil
        }
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
    }
    
    init?(withData data: [String : Any]) {
        guard let sourceString = data["sourceLanguage"] as? String,
        let sourceLanguage = Language(rawValue: sourceString),
        let targetString = data["targetLanguage"] as? String,
            let targetLanguage = Language(rawValue: targetString) else {
                return nil
        }
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
    }
    
    static var `default`:LanguageBind { .init(source: .rus, target: .eng) }
}

extension LanguageBind: Hashable {
    static func == (lhs: LanguageBind, rhs: LanguageBind) -> Bool {
        return lhs.id == rhs.id
    }
}

extension LanguageBind: CustomStringConvertible {
    var description: String {
        return "From \(sourceLanguage) to \(targetLanguage)"
    }
}

extension LanguageBind: SringRepresantation {
    var stringRepresentation: String {
        return "\(sourceLanguage.rawValue)\(LanguageBind.k_separator)\(targetLanguage.rawValue)"
    }
}

extension LanguageBind: DataRepresentation {
    var representation: [String : Any] {
        return [
            "sourceLanguage": sourceLanguage.rawValue,
            "targetLanguage": targetLanguage.rawValue
        ]
    }
}
