//
//  ModalTransitionAnimatorProtocol.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

protocol ModalTransitionAnimatorProtocol: UIViewControllerAnimatedTransitioning {
    // Check, if view controllers can make animate transition
    func isValidatedPresentedViewController(_ presentedVC: UIViewController) -> Bool
    
    func animator(withType type: NavigationOperationType) -> UIViewControllerAnimatedTransitioning?
}

extension ModalTransitionAnimatorProtocol {
    func isValidatedPresentedViewController(_ presentedVC: UIViewController) -> Bool {
        return presentedVC is TransitionAnimatorMaker
    }
}
