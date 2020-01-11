//
//  TransitionAnimationDelegate.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    var transitionAnimator: TransitionAnimatorProtocol?
    
    init(transitionAnimator: TransitionAnimatorProtocol) {
        super.init()
        self.transitionAnimator = transitionAnimator
    }
    
    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let transitionAnimator = transitionAnimator,
            transitionAnimator.сanPerformCorrectAnimation(fromVC: fromVC, toVC: toVC) else {
            return nil
        }
        
        switch operation {
        case .push:
            return transitionAnimator.animator(withType: .push)
        case .pop:
            return transitionAnimator.animator(withType: .pop)
        default:
            return nil
        }
    }
}
