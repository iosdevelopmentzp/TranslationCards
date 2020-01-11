//
//  CustomOperators.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 13.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

// MARK: - Compare optional objects
infix operator ==? : ComparisonPrecedence

func ==? <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func ==? <T: AnyObject>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs === rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func ==? <T: Equatable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

