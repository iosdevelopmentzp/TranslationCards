//
//  ModalTransitionAnimator.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class  ModalTransitionAnimator: NSObject, ModalTransitionAnimatorProtocol {
    
    fileprivate var type: NavigationOperationType = .present
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        
        switch type {
        case .push, .pop:
            fatalError("Attempt modal presentation with \(type) type.")
        case .present:
            guard let toVC = transitionContext.viewController(forKey: .to) as? TransitionAnimatorMaker,
            toVC.typesWhichSupportedAnimation().contains(type) else {
                fatalError("Failed when get TransitionAnimatorMaker from transitionContext")
            }
            toVC.startAnimationBeforeAppear(withDelay: 0,
                                            duration: duration,
                                            secondViewController: transitionContext.viewController(forKey: .from),
                                            containerView: transitionContext.containerView,
                                            transitionType: .present)
        case .dismiss:
            guard let toVC = transitionContext.viewController(forKey: .to),
                let fromVC = transitionContext.viewController(forKey: .from) as? TransitionAnimatorMaker else {
                fatalError("Failed when get TransitionAnimatorMaker from transitionContext")
            }
            
            guard fromVC.typesWhichSupportedAnimation().contains(type) else {
                fatalError("From view controller \(fromVC) not support navigation operation \(type)")
            }
            
            fromVC.startAnimationBeforeDisappear(withDelay: 0,
                                                 duration: duration,
                                                 secondViewController: toVC,
                                                 containerView: transitionContext.containerView,
                                                 transitionType: .dismiss)
        }
        
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    func animator(withType type: NavigationOperationType) -> UIViewControllerAnimatedTransitioning? {
        switch type {
        case .push, .pop:
            return nil
        case .present, .dismiss:
            self.type = type
            return self
        }
    }
}
