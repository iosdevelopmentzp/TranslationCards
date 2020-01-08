//
//  UITextField.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    func preventSpaces() -> Disposable {
        return text.orEmpty
            .map { $0.components(separatedBy: .whitespaces).joined() }
            .bind(to: text)
    }
}
