//
//  SignUpViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class SignUpViewController: ViewController<SignUpRouter, SignUpViewModel> {
    
    fileprivate let bottomBackgroundView = UIView()
    fileprivate let registerCardView = RegisterCardView()
    fileprivate let registerButton = RoundedButton()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(bottomBackgroundView)
        bottomBackgroundView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(self.view.snp.height).multipliedBy(0.7)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.bottom.equalTo(safeArea).inset(30.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(safeArea).multipliedBy(0.8)
        }
        
        view.addSubview(registerCardView)
        registerCardView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30.0)
            $0.width.equalTo(self.registerButton.snp.width)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.bottomBackgroundView).multipliedBy(0.7)
        }
    }
    
    override func setupView() {
        super.setupView()
        
        view.backgroundColor = .mainDarkColor
        
        bottomBackgroundView.backgroundColor = .accentColor
        
        registerButton.backgroundColor = .mainDarkColor
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.hidesBackButton = true
        let rightItem = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(self.logInButtonPressed(sender:)))
        navigationItem.rightBarButtonItem = rightItem
        rightItem.tintColor = .white
    }

    
    override func localizable() {
        super.localizable()
        navigationItem.title = "Register"
        registerButton.setAttributedTitle(.defaultText(withText: "Register"), for: .normal)
    }
    
    // MARK: - User Interaction
    @objc fileprivate func logInButtonPressed(sender: UIBarButtonItem) {
        viewModel.pressedLogInButton()
    }
}

extension SignUpViewController: TransitionAnimationMaker {
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController, containerView: UIView) {
        
        containerView.insertSubview(secondViewController.view, belowSubview: view)
        
        let action = { [weak self] in
            UIView.animate(withDuration: duration, animations: {
                guard let self = self else { return }
                self.bottomBackgroundView.transform = CGAffineTransform.init(translationX: 0, y: self.bottomBackgroundView.bounds.height)
            }) { [weak self] (_) in
                self?.view.alpha = 0.0
            }
            
            UIView.animate(withDuration: duration * 0.5) { [weak self] in
                self?.registerCardView.alpha = 0.0
                self?.registerButton.alpha = 0.0
            }
        }
        guard delay > 0 else {
            action()
            return
        }
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { (_) in
            action()
        }
    }
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController, containerView: UIView) {
        containerView.addSubview(view)
        view.alpha = 0.0
        
        let action = { [weak self] in
            guard let self = self else { return }
            self.bottomBackgroundView.transform = CGAffineTransform.init(translationX: 0, y: self.bottomBackgroundView.bounds.height)
            self.registerButton.alpha = 0.0
            self.registerCardView.alpha = 0.0
            self.view.alpha = 1.0
            
            UIView.animate(withDuration: duration * 0.5) { [weak self] in
                self?.registerCardView.alpha = 1.0
                self?.registerButton.alpha = 1.0
            }

            UIView.animate(withDuration: duration,
                           animations: { [weak self] in
                    self?.bottomBackgroundView.transform = CGAffineTransform.identity
            })
        }
        
        guard delay > 0 else {
            action()
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { (_) in
            action()
        }
    }
    
    
}


