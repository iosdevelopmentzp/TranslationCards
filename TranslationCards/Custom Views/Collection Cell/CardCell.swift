//
//  CardCell.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    let faceSide = CardSide()
    let backSide = CardSide()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.addSubview(faceSide)
        faceSide.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupView() {
        faceSide.backgroundColor = .blue
    }
    
    func configure(withCard card: TranslateCard) {
        faceSide.textLabel.text = card.sourcePhrase
    }
}
