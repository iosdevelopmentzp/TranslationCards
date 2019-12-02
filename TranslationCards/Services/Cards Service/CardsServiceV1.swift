//
//  CardsServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 02.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift

class CardsServiceV1: CardsService {
    let database: DatabaseService
    
    init(database: DatabaseService) {
        self.database = database
    }
    
    func getLanguageBindsList(forUserWithId userId: String) -> Observable<[LanguageBind]> {
        database
            .getLanguageBindesList(forUserId: userId)
    }
    
    func saveCard(_ card: TranslateCard) -> Observable<Void> {
        database
            .saveCard(card)
    }
    
    
}
