//
//  TranslateService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 26.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol TranslateService: Service {
    func translateText(_ sourceText: String, fromLanguage: AzureLanguageReprezantation, toLanguage: AzureLanguageReprezantation) -> Observable<String?>
}
