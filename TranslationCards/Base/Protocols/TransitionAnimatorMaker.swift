//
//  TransitionAnimationMaker.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 25.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit


protocol TransitionAnimatorMaker where Self: UIViewController {
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController, containerView: UIView)
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController, containerView: UIView)
}
