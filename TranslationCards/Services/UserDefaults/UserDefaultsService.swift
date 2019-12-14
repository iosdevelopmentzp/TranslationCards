//
//  UserDefaultsService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 14.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

class UserDefaultsService: KeyValueStorageService {
    
    enum Error: LocalizedError {
        case valueNotFound(forKey: String)
        
        public var errorDescription: String? {
            switch self {
            case .valueNotFound(let key):
                return NSLocalizedString("Value for key \"\(key)\" not found.", comment: "UserDefaultsService.Error")
            }
        }
    }
    
    fileprivate let defaults = UserDefaults.standard
    
    func setValue(_ value: Any, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func value<T>(forKey key: String) throws -> T {
        if let value = defaults.value(forKey: key) as? T {
            return value
        }
        throw Error.valueNotFound(forKey: key)
    }
    
    func deleteValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}

