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
    func сanPerformCorrectAnimation(fromVC: UIViewController, toVC: UIViewController) -> Bool
    
    /// method for triger of navigation operation type before transition
    func animator(withType type: ViewControllerTransitionType) -> UIViewControllerAnimatedTransitioning?
}

extension TransitionAnimatorProtocol {
    func сanPerformCorrectAnimation(fromVC: UIViewController, toVC: UIViewController) -> Bool {
        guard  fromVC is TransitionAnimationMaker,
               toVC  is TransitionAnimationMaker else {
            return false
        }
        return true
    }
}
