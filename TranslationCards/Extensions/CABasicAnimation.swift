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
}

extension CABasicAnimation {
    static func animation(withKeyType key: AnimationKeyType, duration: TimeInterval, fromValue: Any?, toValue: Any?, delay: TimeInterval = 0) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key.rawValue)
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        if let fromValue = fromValue {
            animation.fromValue = fromValue
        }
        if let toValue = toValue {
            animation.toValue = toValue
        }
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}
