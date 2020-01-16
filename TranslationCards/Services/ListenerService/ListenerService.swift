//
//  ListenerService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 16.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ListenerService: Service {
    var userСhangesListener: BehaviorRelay<UserChanges> { get }
    var cardsChangesListener: BehaviorRelay<CardChanges> { get }
}
