//
//  BackCardSideView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 07.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class BackCardSideView: UIView {

    fileprivate let topContainerView = UIView()
    fileprivate let topImageView = UIImageView()
    fileprivate let topTextLabel = UILabel()
    
    fileprivate let bottomContainerView = UIView()
    fileprivate let bottomImageView = UIImageView()
    fileprivate let bottomTextLabel = UILabel()
    
    fileprivate let stackView = UIStackView()
    
    fileprivate let cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withCard card: TranslateCard) {
        topImageView.image = card.language.sourceLanguage.flagIcon
        topTextLabel.text = card.sourcePhrase
        topContainerView.backgroundColor  = card.language.sourceLanguage.associativeColor
       
        bottomImageView.image = card.language.targetLanguage.flagIcon
        bottomTextLabel.text = card.targetPhrase
        bottomContainerView.backgroundColor = card.language.targetLanguage.associativeColor
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        
        let padding = 8.0
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(topContainerView)
        stackView.addArrangedSubview(bottomContainerView)
        
        let topImageContainer = UIView()
        let bottomImageContainer = UIView()
        topImageContainer.addSubview(topImageView)
        bottomImageContainer.addSubview(bottomImageView)
        topContainerView.addSubview(topImageContainer)
        topContainerView.addSubview(topTextLabel)
        bottomContainerView.addSubview(bottomImageContainer)
        bottomContainerView.addSubview(bottomTextLabel)
        
        [topImageView, bottomImageView].forEach {
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        [topImageContainer, bottomImageContainer].forEach {
            $0.snp.makeConstraints {
                $0.top.left.equalToSuperview().offset(padding)
                $0.width.height.equalTo(44.0)
            }
        }
        
        topTextLabel.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
            $0.bottom.lessThanOrEqualTo(self.topContainerView.snp.bottom)
            $0.left.equalTo(topImageContainer.snp.right).offset(padding)
        }
        
        bottomTextLabel.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
            $0.bottom.lessThanOrEqualTo(self.bottomContainerView.snp.bottom)
            $0.left.equalTo(bottomImageContainer.snp.right).offset(padding)
        }
    }
    
    fileprivate func setupView() {
        setShadow(withColor: .white,
                  opacity: 0.4,
                  radius: 5.0,
                  offset: .init(width: 2.0, height: 2.0))
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        topImageView.contentMode = .scaleAspectFit
        bottomImageView.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }
}
