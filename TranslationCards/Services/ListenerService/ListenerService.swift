//
//  ListenerService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 16.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
/// The service is used to deliver notifications of changes that occur either with the user or with some kind of card. This service should be used by view models to update the view interface, or other classes that are subscribed to changes.

protocol ListenerService: Service {
    var userСhangesListener: BehaviorRelay<UserChanges> { get }
    var cardsChangesListener: BehaviorRelay<CardChanges> { get }
    
    func startListenLanguageList(forUserWithId userId: String) -> Observable<[LanguageBind]>
}
