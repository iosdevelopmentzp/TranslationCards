//
//  CABasicAnimation.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 16.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

enum AnimationKeyType: String {
    case translationY = "transform.translation.y"
    case translationX = "transform.translation.x"
    case opacity = "opacity"
    case positionX = "position.x"
    case positionY = "position.y"
    case backgroundColor = "backgroundColor"
}

extension CABasicAnimation {
    
    /// Parameters defaults:
    /// timingFunction = CAMediaTimingFunction(name: .linear) 
    /// fillMode = .forwards
    /// isRemovedOnCompletion = false
    static func animation(withKeyType key: AnimationKeyType, duration: TimeInterval, fromValue: Any?, toValue: Any?, beginTime: TimeInterval? = nil) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key.rawValue)
        animation.duration = duration
        if let beginTime = beginTime {
            animation.beginTime = beginTime
        }
        if let fromValue = fromValue {
            animation.fromValue = fromValue
        }
        if let toValue = toValue {
            animation.toValue = toValue
        }
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}
