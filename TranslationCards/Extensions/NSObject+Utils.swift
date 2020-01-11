//
//  NSObject.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

extension NSObject {
    static var typeName: String {
        return String(describing: self)
    }
}
