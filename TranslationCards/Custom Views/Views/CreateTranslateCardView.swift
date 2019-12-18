//
//  CreateTranslateCardView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CreateTranslateCardView: UIView {
    let sourceTextField = UITextView()
    let sourceHeaderLabel = UILabel()
    let sourceSelectLanguageButton = UIButton(type: .custom)
    
    let targetHeaderLabel = UILabel()
    let targetTextField = UITextView()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    let buttonStackView = UIStackView()
    let verticalButtonStackView = UIStackView()
    let removeButton = UIButton()
    let targetSelectLanguageButton = UIButton(type: .custom)
    
    fileprivate let diposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withCard card: TranslateCard) {
        sourceTextField.text = card.sourcePhrase
        targetTextField.text = card.targetPhrase
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        let padding: CGFloat = 16.0

        addSubview(sourceHeaderLabel)
        sourceHeaderLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(padding * 1.5)
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
        }
        
        addSubview(sourceTextField)
        sourceTextField.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.sourceHeaderLabel.snp.bottom)
            $0.left.equalToSuperview().offset(padding)
        }
        
        addSubview(targetHeaderLabel)
        targetHeaderLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.sourceTextField.snp.bottom).offset(padding / 2)
            $0.left.equalToSuperview().offset(padding * 1.5)
            $0.right.equalToSuperview().inset(padding)
        }
        
        addSubview(targetTextField)
        targetTextField.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.targetHeaderLabel.snp.bottom)
            $0.left.equalToSuperview().offset(padding)
            $0.height.equalTo(self.sourceTextField.snp.height)
        }
        
        addSubview(sourceSelectLanguageButton)
        sourceSelectLanguageButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.sourceTextField.snp.top).offset(4.0)
            $0.right.equalToSuperview().inset(padding)
            $0.width.height.equalTo(30.0)
            $0.left.equalTo(self.sourceTextField.snp.right).offset(4.0)
        }
        
        addSubview(targetSelectLanguageButton)
        targetSelectLanguageButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.targetTextField.snp.top).offset(4.0)
            $0.right.equalToSuperview().inset(padding)
            $0.width.height.equalTo(30.0)
            $0.left.equalTo(self.targetTextField.snp.right).offset(4.0)
        }
        
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(saveButton)
        [cancelButton, saveButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50.0) }
        }
        
        addSubview(verticalButtonStackView)
        verticalButtonStackView.addArrangedSubview(buttonStackView)
        verticalButtonStackView.addArrangedSubview(removeButton)
        removeButton.snp.makeConstraints {
            $0.height.equalTo(30.0)
        }
        
        verticalButtonStackView.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.targetTextField.snp.bottom).offset(padding)
            $0.left.equalToSuperview().offset(padding)
            $0.right.bottom.equalToSuperview().inset(padding)
        }
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 10.0
        backgroundColor = .clear

        [sourceHeaderLabel, targetHeaderLabel].forEach {
            $0.textColor = .white
            $0.font = .font(type: .roboto, weight: .regular, size: 40.0)
        }
        
        [sourceTextField, targetTextField].forEach {
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 9.0
            $0.backgroundColor = .white
            $0.font = .font(type: .roboto, size: 20.0)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.textColor = .black
        }
        
        [cancelButton, saveButton, removeButton].forEach {
            $0.setBorder(withColor: .borderColotDak, borderWidth: 1.0, cornerRadius: 10.0)
        }
        saveButton.backgroundColor = .validateAccentColor
        cancelButton.backgroundColor = .cancelButton
        removeButton.backgroundColor = .removeButton
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10.0
        
        verticalButtonStackView.axis = .vertical
        verticalButtonStackView.spacing = 10.0
    }
}