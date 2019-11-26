//
//  NSAttributedString.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func placeholder(withText text: String, size: CGFloat = 17.0) -> NSAttributedString {
        .init(string: text,
              attributes: [
                .font : UIFont.robotoThin(size: size),
                .foregroundColor: UIColor.placeholderLightColor
        ])
    }
    
    static func defaultText(withText text: String, size: CGFloat = 17.0) -> NSAttributedString {
        .init(string: text,
              attributes: [
                .font : UIFont.robotoRegular(size: size),
                .foregroundColor: UIColor.defaultTextColor
        ])
    }
    
    static func accent(withText text: String, size: CGFloat = 17.0) -> NSAttributedString {
        .init(string: text,
              attributes: [
                .font : UIFont.robotoRegular(size: size),
                .foregroundColor: UIColor.accentColor
        ])
    }
    
    static var navigationBarTitleAttribute: [NSAttributedString.Key : Any] {
        return [ .foregroundColor: UIColor.white ]
    }
    
    static var navigationBarButtomItemAttribute: [NSAttributedString.Key : Any] {
        return [
            .foregroundColor: UIColor.accentColor,
            .font: UIFont.robotoRegular(size: 23.0)
        ]
    }
}
