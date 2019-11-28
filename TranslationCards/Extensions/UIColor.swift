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
    static var placeholderLightColor: UIColor { .white }
    static var placeholderDarkColor: UIColor { .init(red: 200.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1.0) }
    static var defaultTextColor: UIColor { .white }
    static var separatorColor: UIColor { .init(red: 200.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1.0)}
    static var notValidateButton: UIColor { UIColor.gray }
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
