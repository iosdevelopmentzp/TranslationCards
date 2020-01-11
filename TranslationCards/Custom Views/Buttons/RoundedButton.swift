//
//  RoundedButton.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    // MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2.0
    }
    
    // MARK: - Private
    private func setupView() {
        backgroundColor = .accentColor
        contentEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
}
