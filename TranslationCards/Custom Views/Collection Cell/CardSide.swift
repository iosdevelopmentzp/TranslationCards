//
//  CardSide.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class CardSide: UIView {

    fileprivate(set) var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.right.equalToSuperview().inset(8.0)
            $0.top.greaterThanOrEqualTo(self).offset(8.0)
            $0.bottom.lessThanOrEqualTo(self).inset(8.0)
        }
    }
    
    func setupView() {
        layer.cornerRadius = 10.0
        textLabel.numberOfLines = 0
    }
}
