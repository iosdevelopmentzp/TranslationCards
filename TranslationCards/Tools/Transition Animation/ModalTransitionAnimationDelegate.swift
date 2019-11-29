//
//  ModalTransitionAnimator.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class ModalTransitionAnimationDelegate: NSObject, ModalTransitionDelegate {
    let animator: ModalTransitionAnimatorProtocol
    
    init(modalAnimator: ModalTransitionAnimatorProtocol) {
        self.animator = modalAnimator
        super.init()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard animator.isValidatedPresentedViewController(presented) else {
            return nil
        }
        return animator.animator(withType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard animator.isValidatedPresentedViewController(dismissed) else {
            return nil
        }
        return animator.animator(withType: .dismiss)
    }
}
