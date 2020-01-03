//
//  Array.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 02.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import Foundation

extension Array {
    mutating func dropFirstElement() -> Array {
        remove(at: 0)
        return self
    }
    
    var lastIndex: Int {
        return count - 1
    }
}
