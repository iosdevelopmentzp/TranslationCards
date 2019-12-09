//
//  String.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import NaturalLanguage

extension String {
    var isEmail: Bool {
       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
       return testEmail.evaluate(with: self)
    }
    
    func detectLanguage() -> String? {
        if #available(iOS 12.0, *) {
            let recognizer = NLLanguageRecognizer()
            recognizer.processString(self)
            guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
            let detectedLangauge = Locale.current.localizedString(forIdentifier: languageCode)
            return detectedLangauge
        } else {
            guard let languageCode = NSLinguisticTagger.dominantLanguage(for: self) else {
                return nil
            }
            let detectedLangauge = Locale.current.localizedString(forIdentifier: languageCode)
            return detectedLangauge
        }
    }
}
