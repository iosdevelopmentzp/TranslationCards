//
//  UIColor.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainDarkColor: UIColor { UIColor(hexString: "1B1B1B")! }
    static var secondaryUiColor: UIColor { .white }
    static var accentColor: UIColor { UIColor(hexString: "F9D342")! }
    static var validateAccentColor: UIColor { UIColor.green }
    static var placeholderLightColor: UIColor { .white }
    static var placeholderDarkColor: UIColor { .init(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0) }
    static var defaultTextColor: UIColor { .white }
    static var separatorColor: UIColor { .init(red: 200.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1.0)}
    static var shadowColorDark: UIColor { .lightGray }
    static var shadowColorLight: UIColor { .white }
    static var borderColorLight: UIColor { .lightGray }
    static var borderColotDak: UIColor { .darkGray }
    
    
    // Buttons
    static var notValidateButton: UIColor { .gray }
    static var cancelButton: UIColor? { UIColor.init(hexString: "E64F60") }
}

extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension UIColor {
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
