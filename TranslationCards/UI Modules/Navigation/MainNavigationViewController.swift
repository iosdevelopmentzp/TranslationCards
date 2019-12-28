//
//  MainNavigationViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class MainNavigationViewController: NavigationViewController<MainNavigationRouter, MainNavigationViewModel> {
    
    fileprivate let actionButton = JJFloatingActionButton.tunedButton
    fileprivate lazy var addCardButton = JJActionItem.initWith(imageType: .plus)
    
    override func setupConstraints() {
        super.setupConstraints()
        actionButton.display(inViewController: self)
    }
    
    override func setupView() {
        super.setupView()
        hideSeparator()
        actionButton.addItem(addCardButton)
    }
    
    override func localizable() {
        super.localizable()
        addCardButton.titleLabel.text = "New card"
    }
    
    override func binding() {
        super.binding()
        viewModel.bind(addCardPressed: addCardButton.rx.tap)
    }
    
    public func configureActionButtons(_ buttons: [JJActionItem]) {
        var newButtons = buttons
        newButtons.insert(addCardButton, at: 0)
        actionButton.items = newButtons
    }
    
    // MARK: - Override
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewModel.willPresentViewController(viewControllerToPresent, isAnimated: flag)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
