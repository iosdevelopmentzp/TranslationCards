//
//  SignUpViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class SignUpViewController: ViewController<SignUpRouter, SignUpViewModel> {
    
    private let bottomBackgroundView = UIView()
    private let registerCardView = RegisterCardView()
    private let signUpButton = RoundedButton()
    private let backToSignInBarButton = UIBarButtonItem()
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(bottomBackgroundView)
        bottomBackgroundView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(self.view.snp.height).multipliedBy(0.7)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.8)
        }
        
        view.addSubview(registerCardView)
        registerCardView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30.0)
            $0.width.equalTo(self.signUpButton.snp.width)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.bottomBackgroundView).multipliedBy(0.7)
        }
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .mainBackgroundColor
        bottomBackgroundView.backgroundColor = .accentColor
        signUpButton.backgroundColor = .notValidateButton
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = backToSignInBarButton
        backToSignInBarButton.tintColor = .white
    }
    
    override func binding() {
        super.binding()
        
        let input = viewModel.input
        let output = viewModel.output
        
        registerCardView
            .loginTextField
            .textField.rx
            .text
            .unwrap()
            .subscribe(input.logInText)
            .disposed(by: disposeBag)
        
        registerCardView
            .passwordTextField
            .textField.rx
            .text
            .unwrap()
            .subscribe(input.passwordText)
            .disposed(by: disposeBag)
        
        registerCardView
            .displayNameTextField
            .textField.rx
            .text
            .unwrap()
            .subscribe(input.displayNameText)
            .disposed(by: disposeBag)
        
        signUpButton.rx
            .tap
            .subscribe(input.signUpTap)
            .disposed(by: disposeBag)
        
        backToSignInBarButton.rx
            .tap
            .subscribe(input.backToLogInTap)
            .disposed(by: disposeBag)
        
        output
            .isInputCorrect
            .bind(to: signUpButton.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        output
            .isInputCorrect
            .distinctUntilChanged()
            .map { $0 ? UIColor.mainBackgroundColor : UIColor.notValidateButton }
            .observeOn(MainScheduler.instance)
            .filter{ [weak self] in
                guard let currentColor = self?.signUpButton.backgroundColor else { return false }
                return currentColor != $0 }
            .executeWithAnimation(duration: 0.3, animationBlock: { [weak self] (newColor) in
                self?.signUpButton.backgroundColor = newColor
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        registerCardView
            .loginTextField
            .textField.rx
            .preventSpaceCharacters()
            .disposed(by: disposeBag)
        
        registerCardView
            .passwordTextField
            .textField.rx
            .preventSpaceCharacters()
            .disposed(by: disposeBag)
        
        view.rx.addTapGestureToHideKeyboard().disposed(by: disposeBag)
    }
    
    override func localize() {
        super.localize()
        navigationItem.title = "Sign Up"
        signUpButton.setAttributedTitle(.defaultText(withText: "To Sign Up"), for: .normal)
        registerCardView.loginTextField.topLabel.text = "Set your email"
        registerCardView.passwordTextField.topLabel.text = "Password"
        registerCardView.displayNameTextField.topLabel.text = "Set your display name"
        backToSignInBarButton.title = "Log in"
    }
}

extension SignUpViewController: TransitionAnimationMaker {
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType) {
        guard let secondViewController = secondViewController else { return }
        containerView.insertSubview(secondViewController.view, belowSubview: view)
        
        let action = { [weak self] in
            UIView.animate(withDuration: duration, animations: {
                guard let self = self else { return }
                self.bottomBackgroundView.transform = CGAffineTransform.init(translationX: 0, y: self.bottomBackgroundView.bounds.height)
            }) { [weak self] (_) in
                self?.view.alpha = 0.0
                if transitionType == .pop {
                    self?.view.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: duration * 0.5) { [weak self] in
                self?.registerCardView.alpha = 0.0
                self?.signUpButton.alpha = 0.0
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
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType) {
        containerView.addSubview(view)
        view.alpha = 0.0
        
        let action = { [weak self] in
            guard let self = self else { return }
            self.bottomBackgroundView.transform = CGAffineTransform.init(translationX: 0, y: self.bottomBackgroundView.bounds.height)
            self.signUpButton.alpha = 0.0
            self.registerCardView.alpha = 0.0
            self.view.alpha = 1.0
            
            UIView.animate(withDuration: duration * 0.5) { [weak self] in
                self?.registerCardView.alpha = 1.0
                self?.signUpButton.alpha = 1.0
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


