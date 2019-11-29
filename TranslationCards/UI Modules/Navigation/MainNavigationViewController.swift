//
//  MainNavigationViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class MainNavigationViewController: NavigationViewController<MainNavigationRouter, MainNavigationViewModel> {
    
    override func setupView() {
        super.setupView()
        hideSeparator()
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewModel.willPresentViewController(viewControllerToPresent, isAnimated: flag)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
