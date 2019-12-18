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
    
    fileprivate let actionButton = JJFloatingActionButton()
    fileprivate lazy var addCardButton = actionButton.addItem()
    
    override func setupConstraints() {
        super.setupConstraints()
        actionButton.display(inViewController: self)
    }
    
    override func setupView() {
        super.setupView()
        hideSeparator()
        
        // Action button appereance settings.
        actionButton.handleSingleActionDirectly = false
        actionButton.buttonColor = .accentColor
        actionButton.itemAnimationConfiguration = .popUp()
        actionButton.configureDefaultItem { (item) in
            JJActionItem.setupAppearance(forItem: item)
        }
        
        // AddCardButton settings.
        addCardButton.titleLabel.text = "New card"
        addCardButton.imageView.image = .image(withType: .plus, renderringMode: .alwaysTemplate)
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
