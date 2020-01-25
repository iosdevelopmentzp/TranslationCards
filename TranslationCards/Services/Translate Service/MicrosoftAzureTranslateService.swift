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
    
    func translateText(_ sourceText: String, fromLanguage: AzureLanguageReprezantation, toLanguage: AzureLanguageReprezantation) -> Observable<String?> {
        
        let request = AzureRequestType.translate(sourceText: sourceText, fromLanguage: fromLanguage, toLanguage: toLanguage).generateRequest()
        
        return RxAlamofire
            .requestData(request)
            .debug()
            .flatMap({ (response, data) -> Observable<Data> in
                guard response.statusCode == 200 else {
                    var errorMessage: String = ""
                    if let errorModel = try? JSONDecoder().decode(AzureErrorJson.self, from: data) {
                        errorMessage = "Error translate \"\(sourceText)\". Status code - \(errorModel.error.code). Error message - \"\(errorModel.error.message)\""
                    } else {
                        errorMessage = "Error translate \"\(sourceText)\". Status code - \(response.statusCode). Without error message."
                    }
                    debugPrint(errorMessage)
                    return .error(Error.failedTranslate(message: errorMessage))
                }
                return Observable.just(data)
            })
            .map({ data -> String? in
                return try? JSONDecoder()
                    .decode(Array<TranslateReturnedJson>.self, from: data)
                    .first?
                    .translations
                    .first?
                    .text
            })
    }
    
    enum Error: LocalizedError {
        case failedTranslate(message: String)
        
        var errorDescription: String? {
            switch self {
            case .failedTranslate(let message):
                return message
            }
        }
    }
}
