//
//  Language.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 07.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
///Users/dmytrovorko/Projects/GitHub/TranslationCards/TranslationCards/Extensions/NSAttributedString.swift

import UIKit

enum Language: String, CustomStringConvertible, CaseIterable {
    case rus
    case eng
    case spa
    case deu
    
    func next() -> Language {
        let allCases = type(of: self).allCases
        return allCases[(allCases.firstIndex(of: self)! + 1) % allCases.count]
    }
    
    var description: String {
        switch self {
        case .rus:
            return "Russian"
        case .eng:
            return "English"
        case .spa:
            return "Spanich"
        case .deu:
            return "Deutsch"
        }
    }
    
    var flagIcon: UIImage? {
        return .flagIcon(forLanguage: self)
    }
    
    var associativeColor: UIColor {
        switch self {
        case .rus:
            return UIColor(hexString: "0C1AA3")!
        case .eng:
            return UIColor(hexString: "C80F24")!
        case .spa:
            return UIColor(hexString: "C60A1F")!
        case .deu:
            return UIColor(hexString: "FFCF00")!
        }
    }
}
