//
//  LanguageCell.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 07.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    
    fileprivate let containerView = UIView()
    
    fileprivate let leftTitleLabel = UILabel()
    fileprivate let leftBottomImageView = UIImageView()
    
    fileprivate let rightTitleLabel = UILabel()
    fileprivate let rightBottomImageView = UIImageView()
    
    fileprivate let centerTopImageView = UIImageView()
    
    fileprivate let topStackView = UIStackView()
    fileprivate let bottomStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withLanguage language: LanguageBind) {
        leftTitleLabel.text = language.sourceLanguage.description
        leftBottomImageView.image = language.sourceLanguage.flagIcon
        rightTitleLabel.text = language.targetLanguage.description
        rightBottomImageView.image = language.targetLanguage.flagIcon
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        
        let padding: CGFloat = 16.0
        
        let leftDummyView = UIView()
        let containetForImageView = UIView()
        containetForImageView.addSubview(centerTopImageView)
        let rightDummyView = UIView()
        
        containetForImageView.snp.makeConstraints {
            $0.width.height.equalTo(20.0)
        }
        centerTopImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(containerView)
        containerView.addSubview(topStackView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges).inset(padding)
        }
        topStackView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
        }
        
        topStackView.addArrangedSubview(leftTitleLabel)
        topStackView.addArrangedSubview(leftDummyView)
        topStackView.addArrangedSubview(containetForImageView)
        topStackView.addArrangedSubview(rightDummyView)
        rightDummyView.snp.makeConstraints {
            $0.width.equalTo(leftDummyView.snp.width).priority(999)
        }
        topStackView.addArrangedSubview(rightTitleLabel)
        
        containerView.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.topStackView.snp.bottom).offset(padding / 2)
            $0.left.equalToSuperview().offset(padding)
            $0.right.bottom.equalToSuperview().inset(padding)
        }
        
        let leftBottomImageContainer = UIView()
        let rightBottomImageContainer = UIView()
        leftBottomImageContainer.addSubview(leftBottomImageView)
        rightBottomImageContainer.addSubview(rightBottomImageView)
        [leftBottomImageView, rightBottomImageView].forEach {
            $0.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
        bottomStackView.addArrangedSubview(leftBottomImageContainer)
        bottomStackView.addArrangedSubview(UIView())
        bottomStackView.addArrangedSubview(rightBottomImageContainer)
        [leftBottomImageContainer, rightBottomImageContainer].forEach {
            $0.snp.makeConstraints{ $0.width.height.equalTo(40.0)}
        }
    }
    
    fileprivate func setupView() {
        backgroundColor = .clear
        
        containerView.setBorder(withColor: .white,
                              borderWidth: 1.0,
                              cornerRadius: 10.0)
        
        leftTitleLabel.textColor = .defaultTextColor
        rightTitleLabel.textColor = .defaultTextColor
        rightTitleLabel.textAlignment = .right
        
        topStackView.axis = .horizontal
        bottomStackView.axis = .horizontal
        
        centerTopImageView.image = .image(withType: .to, renderringMode: .alwaysTemplate)
        centerTopImageView.contentMode = .scaleAspectFill
        centerTopImageView.tintColor = .validateAccentColor
        
        #if DEBUG
        leftTitleLabel.text = "Left label text"
        rightTitleLabel.text = "RIght label text"
        #endif
    }
}
