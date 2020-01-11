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
    
    func countViewControllersInStack<T: UIViewController>(withType: T.Type) -> Int {
        return viewControllers.filter { $0 is T}.count
    }
    
    func getFirstViewController<T: UIViewController>(withType: T.Type) -> T? {
        return viewControllers.first{ $0 is T} as? T
    }
}
