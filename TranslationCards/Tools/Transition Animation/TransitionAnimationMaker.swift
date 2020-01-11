//
//  TransitionAnimationMaker.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 25.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

enum ViewControllerTransitionType: CaseIterable {
    case push
    case pop
    case present
    case dismiss
}
/// Use this protocol, for custom animation during push, pop, present or dismiss operation. Just make your controller support this protocol
protocol TransitionAnimationMaker where Self: UIViewController {
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType)
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType)
    
    func supportedTransitionTypes() -> [ViewControllerTransitionType]
}

extension TransitionAnimationMaker {
    func supportedTransitionTypes() -> [ViewControllerTransitionType] {
        return ViewControllerTransitionType.allCases
    }
}
