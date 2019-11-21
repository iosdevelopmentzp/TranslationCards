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
    
    
    
    

}
