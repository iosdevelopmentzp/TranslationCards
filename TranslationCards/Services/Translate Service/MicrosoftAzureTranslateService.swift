//
//  MicrosoftTranslateService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 26.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

protocol AzureLanguageReprezantation {
    /// return language string representation wich will be used in http request in "from" and "to".
    var azureLanguageRepresantation: String { get }
}

class MicrosoftAzureTranslateService: TranslateService {
    fileprivate struct Host {
        static let main: URL = URL(string: "https://api.cognitive.microsofttranslator.com")!
        static var translate: URL { return main.appendingPathComponent("translate") }
    }
    
    // Public
    func translateText(_ sourceText: String, fromLanguage: AzureLanguageReprezantation, toLanguage: AzureLanguageReprezantation) -> Observable<String?> {
        
        let request = TypeRequest.translate(sourceText: sourceText, fromLanguage: fromLanguage, toLanguage: toLanguage).request
        
        return RxAlamofire
            .requestData(request)
            .debug()
            .map({ (_, data) -> String? in
                return try? JSONDecoder()
                    .decode(Array<TranslateReturnedJson>.self, from: data)
                    .first?
                    .translations
                    .first?
                    .text
            })
    }
    
    // Private
    fileprivate enum TypeRequest {
        case translate(sourceText: String, fromLanguage: AzureLanguageReprezantation, toLanguage: AzureLanguageReprezantation)
        
        var request: URLRequest {
            switch self {
            case .translate(let sourceText, let fromLanguage, let toLanguage):
                var urlComponents = URLComponents(string: Host.translate.absoluteString)!
                urlComponents.queryItems = [
                    URLQueryItem(name: Query.from(language: fromLanguage).name, value: Query.from(language: fromLanguage).value),
                    URLQueryItem(name: Query.to(language: toLanguage).name, value: Query.to(language: toLanguage).value),
                    URLQueryItem(name: Query.apiVersion.name, value: Query.apiVersion.value)
                ]
                var request = URLRequest(url: urlComponents.url!)
                request.httpMethod = "POST"
                request.addValue(Header.azureKey.value, forHTTPHeaderField: Header.azureKey.name)
                request.addValue(Header.contentType.value, forHTTPHeaderField: Header.contentType.name)
                let outputText = OutputTranslateJson(text: sourceText)
                let jsonData = try? JSONEncoder().encode([outputText])
                request.httpBody = jsonData
                return request
            }
        }
    }
    
    fileprivate enum Header: String {
        case azureKey
        case contentType

        var name: String {
            switch self {
            case .azureKey:
                return "Ocp-Apim-Subscription-Key"
            case .contentType:
                return "Content-Type"
            }
        }
        var value: String {
            switch self {
            case .azureKey:
                return "eaf58818dd1149b997447d02c6280427"
            case .contentType:
                return "application/json; charset=UTF-8"
            }
        }
    }
    
    fileprivate enum Query {
        case from(language: AzureLanguageReprezantation)
        case to(language: AzureLanguageReprezantation)
        case apiVersion
        
        var name: String {
            switch self {
            case .from(_):
                return "from"
            case .to(_):
                return "to"
            case .apiVersion:
                return "api-version"
            }
        }
        var value: String {
            switch self {
            case .from(let language):
                return language.azureLanguageRepresantation
            case .to(let language):
                return language.azureLanguageRepresantation
            case .apiVersion:
                return "3.0"
            }
        }
    }
}
