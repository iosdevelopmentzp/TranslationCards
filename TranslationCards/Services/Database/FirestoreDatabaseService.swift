//
//  FirestoreDatabaseService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import FirebaseFirestore
import RxFirebaseFirestore

class FirestoreDatabaseService: NSObject, DatabaseService {
    
    let database = Firestore.firestore()

    // MARK: - User
    func createUser(_ user: User) -> Observable<Void> {
        return database
            .collection(.userCollection)
            .document(user.uid)
            .rx
            .setData(user.representation)
    }
    
    func updateUser(_ user: User) -> Observable<Void> {
        return database
            .collection(.userCollection)
            .document(user.uid)
            .rx
            .setData(user.representation)
    }
    
    func deleteUser(_ user: User) -> Observable<Void> {
        return database
            .collection(.userCollection)
            .document(user.uid)
            .rx
            .delete()
    }
    
    // MARK: - Card
    func saveCard(_ card: TranslateCard) -> Observable<Void> {
         database
            .collection(.userCollection)
            .document(card.userOwnerId)
            .collection(.languages)
            .document(card.language.stringRepresentation)
            .collection(.cards)
            .document()
            .rx
            .setData(card.representation)
    }
}
