//
//  DataRepresentation.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

protocol DataRepresentation {
    var representation: [String: Any] { get }
     init?(withData data: [String: Any])
}
