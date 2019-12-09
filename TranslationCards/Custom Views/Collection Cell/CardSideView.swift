//
//  CardSide.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CardSideView: UIView {

    fileprivate let textLabel = UILabel()
    fileprivate let iconImageView = UIImageView()
    fileprivate var gradientColors: (UIColor, UIColor)?
    fileprivate var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withCard card: TranslateCard) {
        textLabel.text = "\(card.sourcePhrase)"
        iconImageView.image = card.language.sourceLanguage.flagIcon
        
        gradientLayer?.removeFromSuperlayer()
        let topColor = card.language.sourceLanguage.associativeColor
        if let lighterColor = topColor.lighter() {
            gradientLayer = setGradient(colorTop: lighterColor,
                                        colorBottom: topColor)
        }
    }
    
    // MARK: - Private
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
    
    fileprivate func setupConstraints() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.right.equalToSuperview().inset(8.0)
            $0.top.greaterThanOrEqualTo(self).offset(8.0)
            $0.bottom.lessThanOrEqualTo(self).inset(8.0)
        }
        
        let  containerView = UIView()
        containerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { $0.edges.equalToSuperview()}
        addSubview(containerView)
        let imagePadding: CGFloat = 16.0
        containerView.snp.makeConstraints {
            $0.width.height.equalTo(44.0)
            $0.top.left.equalToSuperview().offset(imagePadding)
        }
    }
    
    fileprivate func setupView() {
        setShadow(withColor: .white,
                  opacity: 0.4,
                  radius: 5.0,
                  offset: .init(width: 2.0, height: 2.0))
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.isUserInteractionEnabled = false
        
        iconImageView.contentMode = .scaleAspectFit
    }
}
