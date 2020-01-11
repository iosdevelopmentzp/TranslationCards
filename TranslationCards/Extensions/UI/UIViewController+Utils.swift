//
//  UIViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIViewController {
    var isTopOfNavigationStack: Bool {
        guard let naviagation = navigationController,
            let topViewController = naviagation.viewControllers.last else {
            return false
        }
        return topViewController === self
    }
}
