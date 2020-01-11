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
    
    /// Divides a string into words
    var words: [SubSequence] {
        return split{ !$0.isLetter }
    }
    
    /// Returns the dominant language for the current string if successfully found
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
    
    /// Returns a string in which the first letter is capitalized
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    /// Converts itself to a string with the first capital letter
    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension String {
  var length: Int {
    return count
  }

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, length) ..< length]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                        upper: min(length, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }
}
