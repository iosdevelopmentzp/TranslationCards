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
            .collection(.databaseUserCollection)
            .document(user.uid)
            .rx
            .setData(user.representation)
    }
    
    func updateUser(_ user: User) -> Observable<Void> {
        return database
            .collection(.databaseUserCollection)
            .document(user.uid)
            .rx
            .setData(user.representation)
    }
    
    func deleteUser(_ user: User) -> Observable<Void> {
        return database
            .collection(.databaseUserCollection)
            .document(user.uid)
            .rx
            .delete()
    }
    
    // MARK: - Card
    func saveCard(_ card: TranslateCard) -> Observable<Void> {
         database
            .collection(.databaseUserCollection)
            .document(card.userOwnerId)
            .collection(.databaseLanguagesCollection)
            .document(card.language.stringRepresentation)
            .collection(.databaseCardsCollection)
            .document()
            .rx
            .setData(card.representation)
    }
    
    func getLanguageBindesList(forUserId userId: String) -> Observable<[LanguageBind]> {
        database
            .collection(.databaseUserCollection)
            .document(userId)
            .collection(.databaseLanguagesCollection)
            .rx
            .getDocuments()
            .map({ (snapshot) -> [LanguageBind] in
                var languages: Array<LanguageBind> = []
                snapshot.documents.forEach({ (document) in
                    guard let language = LanguageBind(withString: document.documentID) else {
                        return
                    }
                    languages.append(language)
                })
                return languages
            })
    }
}
