//
//  Date.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 29.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

extension Date {
    
    private static var saveDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        return dateFormatter
    }
    
    var presentAsString: String {
        let result = Date.saveDateFormatter.string(from: self)
        return result
    }
    
    static func initWithString(_ string: String) -> Date? {
         return saveDateFormatter.date(from: string)
    }
}

extension Date
{
    /**
     Present date as string with one of format.
     
    Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
     
    09/12/2018                        --> MM/dd/yyyy
     
    09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
     
    Sep 12, 2:11 PM                   --> MMM d, h:mm a
     
    September 2018                    --> MMMM yyyy
     
    Sep 12, 2018                      --> MMM d, yyyy
     
    Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
     
    2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
     
    12.09.18                          --> dd.MM.yy
     
    10:41:02.112                      --> HH:mm:ss.SSS
    */
    func asString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

