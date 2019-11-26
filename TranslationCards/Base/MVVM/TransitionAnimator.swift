//
//  TransitionFromSignInToSignUp.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class TransitionAnimator:  NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? TransitionAnimationMaker,
            let toVC = transitionContext.viewController(forKey: .to) as? TransitionAnimationMaker else {
                return
        }
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        fromVC.startAnimationBeforeDisappear(withDelay: 0.0, duration: duration/2, secondViewController: toVC, containerView: containerView)
        toVC.startAnimationBeforeAppear(withDelay: duration/2, duration: duration/2, secondViewController: fromVC, containerView: containerView)
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
