//
//  TextFieldWithTopPlaceholder.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldWithTopPlaceholder: UIView {

    // MARK: - Public
    let topLabel = UILabel()
    let textField = UITextField()
    
    // MARK: - Private
    private let separator = UIView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        stackView.axis = .vertical
        stackView.spacing = 5.0
        separator.backgroundColor = .separatorColor
        separator.layer.cornerRadius = 1.0
        topLabel.textColor = .placeholderDarkColor
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
    }
    
    private func setupConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(separator)
        separator.snp.makeConstraints {
            $0.height.equalTo(2.0).priority(999)
        }
    }
}
