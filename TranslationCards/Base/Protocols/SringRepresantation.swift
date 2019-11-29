//
//  SringRepresantation.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 29.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

protocol SringRepresantation {
    var stringRepresentation: String { get }
    init?(withString string: String)
}
