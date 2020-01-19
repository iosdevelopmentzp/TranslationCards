//
//  ListenerServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 16.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseFirestore
import RxFirebaseFirestore

struct CardChanges {
    let cardId: String
    let typeOfChange: RealTimeEvents
    static var empty: Self { return CardChanges(cardId: "", typeOfChange: .nothing)}
    
    enum RealTimeEvents {
        case nothing
        case removed
        case changed
        case movedToAnotherPlaylist
    }
}

struct UserChanges {
    let userId: String
    var typeOfChange: RealTimeEvents
    static var empty: Self { return UserChanges(userId: "", typeOfChange: .nothing)}
    
    enum RealTimeEvents {
        case changedUser
        case changedCardsList(inLanguage: LanguageBind, playlistId: String)
        case changedPlaylistsList(ofLanguage: LanguageBind)
        case changedLanguageLists
        case nothing
    }
}

class ListenerServiceV1: ListenerService {
    
    private let database = Firestore.firestore()
    
    var userСhangesListener: BehaviorRelay<UserChanges> = .init(value: .empty)
    var cardsChangesListener: BehaviorRelay<CardChanges> = .init(value: .empty)
    
    func startListenLanguageList(forUserWithId userId: String) -> Observable<[LanguageBind]> {
        return database
            .collection(.databaseUserCollection)
            .document(userId)
            .collection(.databaseLanguagesCollection)
            .rx
            .addSnapshotListener()
            .map{ $0.compactMap{ LanguageBind(withData: $0.data())  } }
    }
}
