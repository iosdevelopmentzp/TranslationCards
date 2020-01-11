//
//  UIView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 08.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    /// Add a gesture to the view, so that after touching the keyboard hides if necessary
    func addTapGestureToHideKeyboard() -> Disposable {
        let tapGesture = UITapGestureRecognizer(target: nil, action: nil)
        base.addGestureRecognizer(tapGesture)
        return tapGesture.rx
            .event
            .subscribe(onNext: { [weak base] (_) in
                base?.endEditing(true)
            })
    }
}
