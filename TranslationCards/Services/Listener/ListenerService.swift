//
//  ListenerService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import Firebase
import RxFirebaseFirestore

protocol ListenerService: Service {
    func listenLanguageBindList(forUserWithId userId: String) -> Observable<ChangedDocuments<LanguageBind>>
}

