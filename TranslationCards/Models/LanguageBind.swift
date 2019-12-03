//
//  LanguageBind.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 30.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

enum Language: String {
    case rus
    case eng
}

struct LanguageBind: Equatable {
    let sourceLanguage: Language
    let targetLanguage: Language
    static let k_separator = "_"
    
    init(source sourceLanguage: Language, target targetLanguage: Language) {
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