//
//  TransitionAnimator.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

protocol ModalTransitionDelegate: UIViewControllerTransitioningDelegate {
    var animator: ModalTransitionAnimatorProtocol {get}
}


