//
//  UIWindow.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 02.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIWindow {
    static var safeAreaBottomHeight: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            let bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
            return bottomSafeAreaHeight
        } else {
            return 0.0
        }
    }
}
