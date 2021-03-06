//
//  AzureRequestType.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 15.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import Foundation


enum AzureRequestType {
    case translate(sourceText: String, fromLanguage: AzureLanguageReprezantation, toLanguage: AzureLanguageReprezantation)
    
    // MARK: - Public
    func generateRequest() -> URLRequest {
        switch self {
        case .translate(let sourceText, let fromLanguage, let toLanguage):
            var urlComponents = URLComponents(string: AzureHost.translate.absoluteString)!
            urlComponents.queryItems = AzureTranslateQuery.generateQueryItems(fromLanguage: fromLanguage, toLanguage: toLanguage)
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = "POST"
            request.addValue(AzureHeader.azureKey.value, forHTTPHeaderField: AzureHeader.azureKey.fieldName)
            request.addValue(AzureHeader.contentType.value, forHTTPHeaderField: AzureHeader.contentType.fieldName)
            let outputText = OutputTranslateJson(text: sourceText)
            let jsonData = try? JSONEncoder().encode([outputText])
            request.httpBody = jsonData
            return request
        }
    }
}

// MARK: - Private
private struct AzureHost {
    static let main: URL = URL(string: "https://api.cognitive.microsofttranslator.com")!
    static var translate: URL { return main.appendingPathComponent("translate") }
}

private struct AzureHeader {
    typealias HeaderData = (fieldName: String, value: String)
    
    static let azureKey: HeaderData = (fieldName: "Ocp-Apim-Subscription-Key",
                                       value: "1abe1bc19f1a4220b9536696c0ef44ff")
    static let contentType: HeaderData = (fieldName: "Content-Type",
                                          value: "application/json; charset=UTF-8")
}

private struct AzureTranslateQuery {
    static func generateQueryItems(fromLanguage: AzureLanguageReprezantation, toLanguage: AzureLanguageReprezantation) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "from",
                         value: fromLanguage.azureLanguageRepresantation),
            URLQueryItem(name: "to",
                         value: toLanguage.azureLanguageRepresantation),
            URLQueryItem(name: "api-version",
                         value: "3.0")
        ]
    }
}
