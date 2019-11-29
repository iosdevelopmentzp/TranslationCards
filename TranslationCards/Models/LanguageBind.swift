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

struct LanguageBind {
    let sourceLanguage: Language
    let targetLanguage: Language
    
    init?(withString string: String) {
        let components = string.components(separatedBy: "&")
        guard components.count == 2,
            let sourceLanguage = Language(rawValue: components[0]),
            let targetLanguage = Language(rawValue: components[1]) else {
            return nil
        }
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
    }
}

extension LanguageBind: SringRepresantation {
    var stringRepresentation: String {
        return "\(sourceLanguage.rawValue)&\(targetLanguage.rawValue)"
    }
}
