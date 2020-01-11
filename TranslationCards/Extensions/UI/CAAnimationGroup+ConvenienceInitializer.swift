//
//  CAAnimationGroup.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension CAAnimationGroup {
    static func animation(withAnimations animations: [CABasicAnimation], duration: TimeInterval) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        group.animations = animations
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false
        group.duration = duration
        return group
    }
}
