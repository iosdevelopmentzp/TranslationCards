//
//  SignUpViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class SignUpViewController: ViewController<SignUpRouter, SignUpViewModel> {
    
    let bottomBackgroundView = UIView()
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(bottomBackgroundView)
        bottomBackgroundView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(self.view.snp.height).multipliedBy(0.7)
        }
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .mainDarkColor
        bottomBackgroundView.backgroundColor = .accentColor
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .mainDarkColor
        navigationController?.hideSeparator()
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.largeTitleTextAttributes = NSAttributedString.navigationBarTitleAttribute()
    }
    
    override func localizable() {
        super.localizable()
        navigationItem.title = "Register"
    }
}
