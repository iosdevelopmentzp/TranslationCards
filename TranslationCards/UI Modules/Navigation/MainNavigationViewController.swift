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
            item.titleLabel.font = .font(type: .roboto, weight: .regular, size: 17.0)
            item.titleLabel.textColor = .white
            item.buttonColor = .clear
            item.buttonImageColor = .accentColor
            
            item.layer.shadowColor = UIColor.white.cgColor
            item.layer.shadowOffset = CGSize(width: 0, height: 1)
            item.layer.shadowOpacity = Float(0.4)
            item.layer.shadowRadius = CGFloat(2)
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
