//
//  TransitionAnimator.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

protocol TransitionAnimatorProtocol: UIViewControllerAnimatedTransitioning {
    /// Check, if view controllers can make animate transition
    func isValidatedViewControllers(fromVC: UIViewController, toVC: UIViewController) -> Bool
    
    /// method for triger of navigation operation type before transition
    func animator(withType type: NavigationOperationType) -> UIViewControllerAnimatedTransitioning?
}

extension TransitionAnimatorProtocol {
    func isValidatedViewControllers(fromVC: UIViewController, toVC: UIViewController) -> Bool {
        guard  fromVC is TransitionAnimatorMaker,
               toVC  is TransitionAnimatorMaker else {
            return false
        }
        return true
    }
}
