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
    
    var description: String {
        switch self {
        case .rus:
            return "Russian"
        case .eng:
            return "English"
        }
    }
    
    var flagIcon: UIImage? {
        let name = "\(rawValue)Icon"
        guard let imageType = ImageType(rawValue: name)  else {
            return nil
        }
        return .image(withType: imageType, renderringMode: .alwaysOriginal)
    }
    
    var associativeColor: UIColor {
        switch self {
        case .rus:
            return .blue
        case .eng:
            return .red
        }
    }
}
