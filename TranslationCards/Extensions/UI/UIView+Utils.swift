//
//  UIView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 29.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

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
    
    func setBorder(withColor color: UIColor = .borderColotDak, borderWidth: CGFloat = 1.0, cornerRadius: CGFloat? = nil) {
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
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
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setAlpha(_ alpha: CGFloat, withAnimation: Bool = true, duration: TimeInterval = 0.2) {
        guard self.alpha != alpha else { return }
        
        let action = { [weak self] in self?.alpha = alpha }
        guard withAnimation else {
            action()
            return
        }
        UIView.animate(withDuration: duration) { action() }
    }
    
    func getHeightLayoutConstraint() -> NSLayoutConstraint? {
        var constraint: NSLayoutConstraint?
        constraints.forEach {
            guard $0.firstAttribute == .height else { return }
            constraint = $0
        }
        return constraint
    }
    
    func getWidthLayoutConstraint() -> NSLayoutConstraint? {
        var constraint: NSLayoutConstraint?
        constraints.forEach {
            guard $0.firstAttribute == .width else { return }
            constraint = $0
        }
        return constraint
    }
}
