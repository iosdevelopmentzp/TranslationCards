//
//  CreateTranslateCardView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class CreateTranslateCardView: UIView {
    let rootTextField = UITextView()
    let translateLabel = UILabel()
    let translateTextField = UITextView()
    let rootLabel = UILabel()
    let saveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        let padding: CGFloat = 16.0

        addSubview(rootLabel)
        rootLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(padding * 1.5)
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
        }
        
        addSubview(rootTextField)
        rootTextField.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.rootLabel.snp.bottom)
            $0.right.equalToSuperview().inset(padding)
            $0.left.equalToSuperview().offset(padding)
        }
        
        addSubview(translateLabel)
        translateLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.rootTextField.snp.bottom).offset(padding / 2)
            $0.left.equalToSuperview().offset(padding * 1.5)
            $0.right.equalToSuperview().inset(padding)
        }
        
        addSubview(translateTextField)
        translateTextField.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.translateLabel.snp.bottom)
            $0.left.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
            $0.height.equalTo(self.rootTextField.snp.height)
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.translateTextField.snp.bottom).offset(padding)
            $0.left.equalToSuperview().offset(padding)
            $0.bottom.right.equalToSuperview().inset(padding)
            $0.height.equalTo(50.0)
        }
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 10.0
        setShadow()
        backgroundColor = .white
        
        #if DEBUG
        rootLabel.text = "Root label"
        translateLabel.text = "Translate label"
        rootTextField.text = "Test text"
        translateTextField.text = "Test text"
        saveButton.setTitle("Tes save title", for: .normal)
        #endif

        [rootLabel, translateLabel].forEach {
            $0.textColor = .gray
        }
        
        [rootTextField, translateTextField].forEach {
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 9.0
            $0.backgroundColor = .white
            $0.font = .robotoRegular(size: 20.0)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
        }
        saveButton.setBorder(withColor: .borderColotDak, borderWidth: 1.0, cornerRadius: 10.0)
        saveButton.backgroundColor = UIColor.validateAccentColor
        saveButton.setShadow()
    }
}
