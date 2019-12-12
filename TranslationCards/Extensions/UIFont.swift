//
//  UIFont.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

enum FontType: String {
    case roboto = "Roboto"
}

enum FontWeight: String {
    case black = "Black"
    case bold = "Bold"
    case italic = "Italic"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case thin = "Thin"
    
    func withItalic() -> String {
        switch self {
        case .regular, .italic:
            return rawValue
        default:
            return rawValue + "Italic"
        }
    }
}

extension UIFont {
    
    static func font(type: FontType, weight: FontWeight = .regular, withItalic: Bool = false, size: CGFloat = 17.0) -> UIFont {
        let weightName = withItalic ? weight.withItalic() : weight.rawValue
        let fontName = type.rawValue + "-" + weightName
        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("Something went wrong. Failed get font with name \(fontName)")
        }
        return font
    }
}
