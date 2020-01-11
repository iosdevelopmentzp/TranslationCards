//
//  UIColor.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainBackgroundColor: UIColor {
        UIColor(hexString: "112D32")!
//        "255350" - dark green
//        "1B1B1B" - matte black
//        "112D32" - green
    }
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
    static var neutralButton: UIColor { UIColor(hexString: "666666")! }
    static var notValidateButton: UIColor { .gray }
    static var removeButton: UIColor { UIColor(hexString: "d11a2a")!}
    static var cancelButton: UIColor? { UIColor.init(hexString: "E64F60") }
    static var innactiveButtonTitleColor: UIColor { UIColor.lightGray }
    
    // Picker View
    static var pickerViewColor: UIColor { UIColor(hexString: "D2D5DB")! }
    static var pickerViewToolsPanelColor: UIColor { UIColor(hexString: "F8F8F8")! }
    static var pickerViewButtonTitleColor: UIColor { UIColor(hexString: "007BFF")! }
    
    // write phrase view
    static var writePhraseCardBackground: UIColor { UIColor(hexString: "8BA397")!}
    static var writePhraseOneMoreWordActive: UIColor { UIColor(hexString: "473198")!}
    static var writePhraseOneMoreWordInactive: UIColor { .notValidateButton }
}
