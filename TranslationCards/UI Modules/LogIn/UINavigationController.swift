//
//  UINavigationController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UINavigationController {
    func hideSeparator() {
        navigationBar.setValue(true, forKey: "hidesShadow")
    }
}
