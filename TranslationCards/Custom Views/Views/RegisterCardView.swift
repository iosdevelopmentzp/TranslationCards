//
//  RegisterCardView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterCardView: UIView {
    let loginTextField = TextFieldWithTopPlaceholder()
    let passwordTextField = TextFieldWithTopPlaceholder()
    let displayNameTextField = TextFieldWithTopPlaceholder()
    
    fileprivate let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 15.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.8
        backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 5.0
    }
    
    fileprivate func setupConstraints() {
        let padding: CGFloat = 16.0
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview().priority(999)
            $0.left.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
            $0.bottom.equalToSuperview().inset(padding * 2)
            $0.top.equalToSuperview().offset(padding)
        }
        
        let textFields = [loginTextField, passwordTextField, displayNameTextField]
        textFields.forEach { [weak self] in
            self?.stackView.addArrangedSubview($0)
        }
        
        if let firstTextField = textFields.first {
            textFields.forEach { (textField) in
                if textField !== firstTextField {
                    textField.snp.makeConstraints {
                        $0.height.equalTo(firstTextField.snp.height).priority(999) }
                }
            }
        }
    }
}
