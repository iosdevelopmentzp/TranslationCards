//
//  LogInViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LogInViewController: ViewController<LogInRouter, LogInViewModel> {
    
    private let loginTextField = RoundedTextField()
    private let passwordTextField = RoundedTextField()
    private let logInButton = RoundedButton()
    private let signUpButton = UIButton()
    private let stackView = UIStackView()
    
    override func setupConstraints() {
        super.setupConstraints()
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(safeArea.snp.width).multipliedBy(0.7)
        }
        
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(logInButton)
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeArea.snp.bottom).inset(20.0)
        }
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .mainBackgroundColor
        stackView.axis = .vertical
        stackView.spacing = 25.0
        [passwordTextField, loginTextField].forEach {
            $0.borderWidth = 2.0
            $0.borderColor = .secondaryUiColor
            $0.autocapitalizationType = .none
        }
        
        #if DEBUG
        loginTextField.text = "dima@gmail.com"
        passwordTextField.text = "testtest"
        #endif
    }
    
    override func localize() {
        super.localize()
        loginTextField.placeholderText = "Your Email"
        passwordTextField.placeholderText = "Password"
        logInButton.setAttributedTitle(.defaultText(withText: "login".uppercased()), for: .normal)
        signUpButton.setAttributedTitle(.accent(withText: "Sign Up"), for: .normal)
        navigationItem.title = "Log In"
    }
    
    override func binding() {
        super.binding()
        
        let input = viewModel.input
        let output = viewModel.output
        
        loginTextField.rx.preventSpaceCharacters().disposed(by: disposeBag)
        passwordTextField.rx.preventSpaceCharacters().disposed(by: disposeBag)
        view.rx.addTapGestureToHideKeyboard().disposed(by: disposeBag)
        
        loginTextField.rx
            .text
            .unwrap()
            .subscribe(input.logInText)
            .disposed(by: disposeBag)
        
        passwordTextField.rx
            .text
            .unwrap()
            .subscribe(input.passwordText)
            .disposed(by: disposeBag)
        
        logInButton.rx
            .tap
            .subscribe(input.logInAction)
            .disposed(by: disposeBag)
        
        signUpButton.rx
            .tap
            .bind(to: viewModel.input.signUpAction)
            .disposed(by: disposeBag)
        
        output
            .isValidetText
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .bind(to: logInButton.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        output
            .isValidetText
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .map { $0 ? UIColor.accentColor : UIColor.notValidateButton }
            .subscribe(onNext: { [weak self] (newColor) in
                guard let currentColor = self?.logInButton.backgroundColor,
                currentColor != newColor else { return }
                UIView.animate(withDuration: 0.3) {
                    self?.logInButton.backgroundColor = newColor
                }})
            .disposed(by: disposeBag)
    }
}

extension LogInViewController: TransitionAnimationMaker {
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType) {
        
        let action = { [weak self] in
            UIView.animate(withDuration: duration, animations: {
                [self?.logInButton, self?.passwordTextField, self?.loginTextField].forEach {
                    $0?.alpha = 0.0
                }
            }, completion: {[weak self] (_) in
                if transitionType == .pop {
                    self?.view.removeFromSuperview()
                }
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
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType) {
        let action = { [weak self] in
            UIView.animate(withDuration: duration) {
                [self?.logInButton, self?.passwordTextField, self?.loginTextField].forEach {
                    $0?.alpha = 1.0
                }
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
}
