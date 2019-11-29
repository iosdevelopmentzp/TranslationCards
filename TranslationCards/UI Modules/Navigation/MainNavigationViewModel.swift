//
//  MainNavigationViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class MainNavigationViewModel: NavigationViewModel<MainNavigationRouter> {
    
    let transitionAnimator = TransitionAnimator()
    
    override init(root: UIViewController) {
        super.init(root: root)
        navigationControllerDelegate = NavigationControllerDelegate(transitionAnimator: transitionAnimator)
        modalTransitionAnimatorDelegate = ModalTransitionAnimationDelegate(modalAnimator: ModalTransitionAnimator())
    }
    
    func willPresentViewController(_ viewControllerToPresent: UIViewController, isAnimated: Bool) {
        guard isAnimated else {
            return
        }
        
        if let modalAnimator = modalTransitionAnimatorDelegate,
            modalAnimator.animator.isValidatedPresentedViewController(viewControllerToPresent)
        {
            viewControllerToPresent.modalPresentationStyle = .custom
            viewControllerToPresent.transitioningDelegate = modalAnimator
        }
    }
}
