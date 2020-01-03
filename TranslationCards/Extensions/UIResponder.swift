//
//  UIResponder.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 02.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
