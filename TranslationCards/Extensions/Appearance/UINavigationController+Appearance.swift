//
//  UINavigationController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UINavigationController {
    static func setupAppeareance() {
        let barItemAppearace = UIBarButtonItem.appearance()
        barItemAppearace.setTitleTextAttributes(NSAttributedString.navigationBarButtomItemAttribute, for: .normal)
        barItemAppearace.setTitleTextAttributes(NSAttributedString.navigationBarButtomItemAttribute, for: .highlighted)
        let navigationBarAppearace = UINavigationBar.appearance()
        if #available(iOS 13.0, *) {
            let navBarAppearace = UINavigationBarAppearance()
            navBarAppearace.backgroundColor = .mainBackgroundColor
            navBarAppearace.titleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            navBarAppearace.largeTitleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            UINavigationBar.appearance().standardAppearance = navBarAppearace
           // UINavigationBar.appearance().prefersLargeTitles = true
        } else {
            navigationBarAppearace.barTintColor = .mainBackgroundColor
            navigationBarAppearace.tintColor = .white
            navigationBarAppearace.isTranslucent = false
            navigationBarAppearace.titleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            navigationBarAppearace.largeTitleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            //navigationBarAppearace.prefersLargeTitles = true
        }
    }
}
