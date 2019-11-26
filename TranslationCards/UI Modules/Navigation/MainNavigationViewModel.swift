//
//  MainNavigationViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class MainNavigationViewModel: NavigationViewModel<MainNavigationRouter> {
    
    override init(root: UIViewController) {
        super.init(root: root)
        transitionAnimator = TransitionAnimator()
    }
}
