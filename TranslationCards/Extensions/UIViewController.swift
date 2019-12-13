//
//  UIViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIViewController {
    @discardableResult
    func appendBlurEffect(style: UIBlurEffect.Style) -> UIVisualEffectView? {
        guard !UIAccessibility.isReduceTransparencyEnabled else {
            return nil
        }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        return blurEffectView
        
    }
    
    func getBlurEffect() -> UIVisualEffectView? {
        let blurView = view.subviews.first { $0 is UIVisualEffectView }
        return blurView as? UIVisualEffectView
    }
    
    var isTopOfNavigationStack: Bool {
        guard let naviagation = navigationController,
            let topViewController = naviagation.viewControllers.last else {
            return false
        }
        return topViewController === self
    }
}
