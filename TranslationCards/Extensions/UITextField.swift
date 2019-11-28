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

extension UITextField {
    func preventSpaces(disposeBag: DisposeBag) {
        rx.text
            .compactMap { $0 }
            .map { $0.components(separatedBy: .whitespaces).joined() }
            .bind(to: rx.text)
            .disposed(by: disposeBag)
    }
}
