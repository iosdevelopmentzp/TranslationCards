//
//  MainNavigationViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import JJFloatingActionButton

final class MainNavigationViewController: NavigationViewController<MainNavigationRouter, MainNavigationViewModel> {
    
    /// The main menu button of each ViewController, which is configured  a list of buttons that is taken in the top ViewController and contains the basic tools that are necessary in  context of the current ViewController. By default contains the createNewCardButton.
    private let menuButton = JJFloatingActionButton.tunedButton
    /// The button, which by default is added to the  menuButton in all cases.
    private lazy var createNewCardButton = JJActionItem.initWith(imageType: .plus)
    
    override func setupConstraints() {
        super.setupConstraints()
        menuButton.display(inViewController: self)
    }
    
    override func setupView() {
        super.setupView()
        hideSeparator()
    }
    
    override func localizable() {
        super.localizable()
        createNewCardButton.titleLabel.text = "New card"
    }
    
    override func binding() {
        super.binding()
        createNewCardButton
            .rx.tap
            .bind(to: viewModel.input.createCardTap)
            .disposed(by: disposeBag)
    }
    
    func configureActionButtons(_ buttons: [JJActionItem]) {
        var newButtons = buttons
        newButtons.insert(createNewCardButton, at: 0)
        menuButton.items = newButtons
    }
    
    // MARK: - Override
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewModel.willPresentViewController(viewControllerToPresent, isAnimated: flag)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
