//
//  JJActionItem+Rx.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 08.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import JJFloatingActionButton

extension Reactive where Base: JJActionItem {
    public var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
