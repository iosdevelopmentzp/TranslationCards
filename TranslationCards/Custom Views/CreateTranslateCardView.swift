//
//  CreateTranslateCardView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class CreateTranslateCardView: UIView {
    let sourceTextField = UITextView()
    let targetHeaderLabel = UILabel()
    let targetTextField = UITextView()
    let sourceHeaderLabel = UILabel()
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
            $0.right.equalToSuperview().inset(padding)
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
            $0.right.equalToSuperview().inset(padding)
            $0.height.equalTo(self.sourceTextField.snp.height)
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.targetTextField.snp.bottom).offset(padding)
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
        sourceHeaderLabel.text = "Root label"
        targetHeaderLabel.text = "Translate label"
        sourceTextField.text = "Test text"
        targetTextField.text = "Test text"
        saveButton.setTitle("Tes save title", for: .normal)
        #endif

        [sourceHeaderLabel, targetHeaderLabel].forEach {
            $0.textColor = .gray
        }
        
        [sourceTextField, targetTextField].forEach {
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
