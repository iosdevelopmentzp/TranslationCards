//
//  Date.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 29.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

extension Date {
    
    fileprivate static var saveDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        return dateFormatter
    }
    
    var asString: String {
        let result = Date.saveDateFormatter.string(from: self)
        return result
    }
    
    static func initWithString(_ string: String) -> Date? {
         return saveDateFormatter.date(from: string)
    }
}
