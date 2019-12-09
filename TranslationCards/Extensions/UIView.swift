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
    
    func bringToFront() {
        superview?.bringSubviewToFront(self)
    }
    
    @discardableResult
    func setGradient(colorTop: UIColor, colorBottom: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at:0)
        return gradientLayer
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
