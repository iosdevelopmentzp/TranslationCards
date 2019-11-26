//
//  RegisterCardView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit



class RegisterCardView: UIView {
    
    enum FieldType: Int, CaseIterable {
        case email
        case password
        case displayName
        
        func placeholderText() -> String {
            switch self {
            case .email:
                return "Set your email"
            case .password:
                return "Password"
            case .displayName:
                return "Set your display name"
            }
        }
    }
    
    fileprivate let stackView = UIStackView()
    fileprivate var textFields: [TextFieldWithTopPlaceholder] = []
    fileprivate static let kPadding: CGFloat = 16.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        localizable()
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
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview().priority(999)
            $0.left.equalToSuperview().offset(RegisterCardView.kPadding)
            $0.right.equalToSuperview().inset(RegisterCardView.kPadding)
            $0.bottom.equalToSuperview().inset(RegisterCardView.kPadding * 2)
            $0.top.equalToSuperview().offset(RegisterCardView.kPadding)
        }
        
        FieldType.allCases.forEach { [weak self] (_) in
            let textField = TextFieldWithTopPlaceholder()
            self?.stackView.addArrangedSubview(textField)
            self?.textFields.append(textField)
        }
        
        if let firstTextField = textFields.first {
            textFields.forEach {
                if $0 !== firstTextField {
                    $0.snp.makeConstraints {
                        $0.height.equalTo(firstTextField.snp.height).priority(999) }
                }
            }
        }
    }
    
    fileprivate func localizable() {
        FieldType.allCases.forEach { [weak self] in
            guard let field = self?.textFields[$0.rawValue] else { return }
            field.topPlaceholder.onNext($0.placeholderText())
        }
    }
}
