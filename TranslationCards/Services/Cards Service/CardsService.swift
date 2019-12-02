//
//  CardsService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 02.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift

protocol CardsService: Service {
    func getLanguageBindsList(forUserWithId userId: String) -> Observable<[LanguageBind]>
    func saveCard(_ card: TranslateCard) -> Observable<Void>
}
