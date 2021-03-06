//
//  JJFloatingActionButton.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import JJFloatingActionButton

extension JJActionItem {
    static func setupAppearance(forItem item: JJActionItem) {
        item.titleLabel.font = .font(type: .roboto, weight: .regular, size: 17.0)
        item.titleLabel.textColor = .white
        item.buttonColor = .clear
        item.buttonImageColor = .accentColor
        
        item.layer.shadowColor = UIColor.white.cgColor
        item.layer.shadowOffset = CGSize(width: 0, height: 1)
        item.layer.shadowOpacity = Float(0.4)
        item.layer.shadowRadius = CGFloat(2)
    }
}

