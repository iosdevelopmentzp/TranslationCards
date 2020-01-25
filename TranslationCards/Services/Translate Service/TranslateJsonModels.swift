//
//  TranslateJsonModels.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 26.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

// Translate JSONs
struct TranslateReturnedJson: Codable {
    var translations: [TranslatedString]
}

struct TranslatedString: Codable {
    var text: String
    var to: String
}

struct OutputTranslateJson: Codable {
    var text: String
}

// Get supported languages JSON
struct SupportedLanguagesReturnedJson: Codable {
    var translation: [String: LanaguageDetails]
}

struct LanaguageDetails: Codable {
    var name: String
    var nativeName: String
    var dir: String
}

// Azure error model

struct AzureErrorJson: Codable {
    var error: AzureError
}

struct AzureError: Codable {
    var code: Int
    var message: String
}
