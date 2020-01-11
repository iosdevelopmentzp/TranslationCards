//
//  UIView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 29.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIView {
    /// Setup the default Appearance of all application views
    static func setupAppearance() {
        NVActivityIndicatorView.setupAppereance()
        UINavigationController.setupAppeareance()
    }
}
