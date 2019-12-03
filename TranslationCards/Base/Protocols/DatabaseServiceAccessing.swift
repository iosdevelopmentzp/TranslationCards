//
//  DatabaseAccessing.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

protocol DatabaseServiceAccessing {
    var database: DatabaseService { get }
}

extension DatabaseServiceAccessing {
    var database: DatabaseService {
        return Services.shared.realTimeDatabase
    }
}
