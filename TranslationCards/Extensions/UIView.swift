//
//  UIView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 29.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIView {
    func setShadow(withColor color: UIColor = .shadowColorDark,
                   opacity: CGFloat = 0.7,
                   radius: CGFloat = 4.0,
                   offset: CGSize = .zero) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    func setBorder(withColor color: UIColor = .borderColotDak,
                   borderWidth: CGFloat = 1.0,
                   cornerRadius: CGFloat = 5.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
}
