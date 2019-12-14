//
//  UserDefaultsService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 14.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

protocol KeyValueStorageService: Service {
    func setValue(_ value: Any, forKey key: String)
    func value<T>(forKey key: String) throws -> T
    func deleteValue(forKey key: String)
}
