//
//  TransitionAnimationMaker.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 25.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

enum NavigationOperationType: CaseIterable {
    case push
    case pop
    case present
    case dismiss
}
/// Use this protocol, for custom animation transition during push, pop, present or dismiss operation. Just make your controller support this protocol
protocol TransitionAnimatorMaker where Self: UIViewController {
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: NavigationOperationType)
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: NavigationOperationType)
    
    func typesWhichSupportedAnimation() -> [NavigationOperationType]
}

extension TransitionAnimatorMaker {
    func typesWhichSupportedAnimation() -> [NavigationOperationType] {
        return NavigationOperationType.allCases
    }
}
