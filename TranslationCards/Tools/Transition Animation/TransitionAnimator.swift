//
//  TransitionFromSignInToSignUp.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class TransitionAnimator:  NSObject, TransitionAnimatorProtocol {
    var type: ViewControllerTransitionType = .push
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? TransitionAnimationMaker,
            let toVC = transitionContext.viewController(forKey: .to) as? TransitionAnimationMaker
            else {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                return
        }
        
        guard fromVC.supportedTransitionTypes().contains(type) && toVC.supportedTransitionTypes().contains(type) else {
            fatalError("Attempt navigation operation with unsupported type \(type) for fromVC \(fromVC.description) toVc \(toVC.description)")
        }
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        fromVC.startAnimationBeforeDisappear(withDelay: 0.0, duration: duration/2, secondViewController: toVC, containerView: containerView, transitionType: type)
        toVC.startAnimationBeforeAppear(withDelay: duration/2, duration: duration/2, secondViewController: fromVC, containerView: containerView, transitionType: type)
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func animator(withType type: ViewControllerTransitionType) -> UIViewControllerAnimatedTransitioning? {
        switch type {
        case .push, .pop:
            self.type = type
            return self
        case .present, .dismiss:
            return nil
        }
    }
}
