//
//  MainViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class MainViewController: ViewController<MainRouter, MainViewModel> {
    fileprivate let plusCardButton = PlusButton()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(plusCardButton)
        plusCardButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.width.height.equalTo(60.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30.0)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
        }
    }
    
    override func setupView() {
        super.setupView()
        plusCardButton.tintColor = .white
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.hidesBackButton = true
    }
    
    override func binding() {
        viewModel.bind(plusButtonPressed: plusCardButton.rx.tap)
    }
    
    override func localizable() {
        super.localizable()
        navigationItem.title = "My Cards"
    }
}
