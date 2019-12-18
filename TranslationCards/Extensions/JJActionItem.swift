//
//  JJFloatingActionButton.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import JJFloatingActionButton

extension Reactive where Base: JJActionItem {
    public var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
