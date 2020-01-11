//
//  NSAttributedString.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func placeholderLight(withText text: String, size: CGFloat = 17.0) -> NSAttributedString {
        .init(string: text,
              attributes: [
                .font : UIFont.font(type: .roboto, weight: .thin, size: size),
                .foregroundColor: UIColor.placeholderLightColor
        ])
    }
    
    static func placeholderDark(withText text: String, size: CGFloat = 17.0) -> NSAttributedString {
        .init(string: text,
              attributes: [
                .font : UIFont.font(type: .roboto, weight: .thin, size: size),
                .foregroundColor: UIColor.placeholderDarkColor
        ])
    }
    
    static func defaultText(withText text: String, size: CGFloat = 17.0) -> NSAttributedString {
        .init(string: text,
              attributes: [
                .font : UIFont.font(type: .roboto, weight: .regular, size: size),
                .foregroundColor: UIColor.defaultTextColor
        ])
    }
    
    static func accent(withText text: String, size: CGFloat = 17.0) -> NSAttributedString {
        .init(string: text,
              attributes: [
                .font : UIFont.font(type: .roboto, weight: .regular, size: size),
                .foregroundColor: UIColor.accentColor
        ])
    }
    
    static var navigationBarTitleAttribute: [NSAttributedString.Key : Any] {
        return [ .foregroundColor: UIColor.white ]
    }
    
    static var navigationBarButtomItemAttribute: [NSAttributedString.Key : Any] {
        return [
            .foregroundColor: UIColor.accentColor,
            .font: UIFont.font(type: .roboto, weight: .regular, size: 23)
        ]
    }
    
    static var writeSlideShowNativeText: [NSAttributedString.Key : Any] {
        [.foregroundColor: UIColor.white,
         .font: UIFont.font(type: .roboto, weight: .bold, withItalic: false, size: 17.0)
        ]
    }
    
    static var writeSlideShowTranslateText: [NSAttributedString.Key : Any] {
        [.foregroundColor: UIColor.green,
         .font: UIFont.font(type: .roboto, weight: .bold, withItalic: true, size: 17.0)
        ]
    }
}
