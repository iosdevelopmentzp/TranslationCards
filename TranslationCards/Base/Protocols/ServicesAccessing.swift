//
//  DatabaseAccessing.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

protocol ServicesAccessing {
    var services: Services { get }
}

extension ServicesAccessing {
    var services: Services {
        return Services.shared
    }
}
