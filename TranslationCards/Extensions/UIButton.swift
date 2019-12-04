//
//  UIButton.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIButton {
    // Constructor
    static var playButton: UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.image(withType: .playButton), for: .normal)
        button.tintColor = .accentColor
        return button
    }
}
