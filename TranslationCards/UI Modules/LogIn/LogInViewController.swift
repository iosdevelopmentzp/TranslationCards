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
    
    let loginTextField = RoundedTextField()
    let passwordTextField = RoundedTextField()
    let logInButton = RoundedButton()
    let signUpButton = UIButton()
    let stackView = UIStackView()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
        
        view.addSubview(activityIndicator)
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .mainDarkColor
        
        stackView.axis = .vertical
        stackView.spacing = 25.0
        
        logInButton.backgroundColor = viewModel.isValideText.value ? UIColor.accentColor : UIColor.gray

        [passwordTextField, loginTextField].forEach {
            $0.borderWidth = 2.0
            $0.borderColor = .secondaryUiColor
            $0.autocapitalizationType = .none
        }
    }
    
    override func setupNavigationBar() {
        //navigationController?.isNavigationBarHidden = true
    }
    
    override func localizable() {
        super.localizable()
        loginTextField.placeholderText = "Your Email"
        passwordTextField.placeholderText = "Password"
        logInButton.setAttributedTitle(.defaultText(withText: "login".uppercased()), for: .normal)
        signUpButton.setAttributedTitle(.accent(withText: "Sign Up"), for: .normal)
    }
    
    override func binding() {
        super.binding()
        viewModel.bind(withLogin: loginTextField.rx.text,
                       withPassword: passwordTextField.rx.text,
                       didPressButton: logInButton.rx.tap)
        viewModel
            .isValideText
            .distinctUntilChanged()
            .bind(to: logInButton.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        viewModel
            .isValideText
            .distinctUntilChanged()
            .skip(1)
            .subscribe(onNext: { [weak self] (isValide) in
                UIView.animate(withDuration: 0.3) {
                    self?.logInButton.backgroundColor = isValide ? UIColor.accentColor : UIColor.gray
                }})
            .disposed(by: disposeBag)
        
        viewModel
            .bind(didPressSignUpButton: signUpButton.rx.tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
