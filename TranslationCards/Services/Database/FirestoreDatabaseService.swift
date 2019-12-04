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
    fileprivate let database = Firestore.firestore()
    fileprivate let disposeBag = DisposeBag()

    // MARK: - User
    func createUser(_ user: User) -> Observable<Void> {
        return database
            .collection(.databaseUserCollection)
            .document(user.uid)
            .rx
            .setData(user.representation)
    }
    
    func fetchUser(withUserId userId: String) -> Observable<User?> {
        database
            .collection(.databaseUserCollection)
            .document(userId)
            .rx
            .getDocument()
            .map { (snapshot) -> User? in
                guard let data = snapshot.data() else {
                    return nil
                }
                return User(withData: data) }
    }
    
    func updateUser(withUserId userId: String, withData data: [String: Any]) -> Observable<Void> {
        let userReference = database.collection(.databaseUserCollection).document(userId)
        
        return .create { [weak self] (observer) -> Disposable in
            self?.database.runTransaction({ (transaction, errorPoint) -> Any? in
                
                    transaction.updateData(data, forDocument: userReference)
                
                return nil
            }, completion: { (object, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
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
        return database
            .collection(.databaseUserCollection)
            .document(card.userOwnerId)
            .collection(.databaseLanguagesCollection)
            .document(card.language.stringRepresentation)
            .collection(.databaseCardsCollection)
            .document()
            .rx
            .setData(card.representation)
    }
    
    func getLanguageList(forUserId userId: String) -> Observable<[LanguageBind]> {
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
    
    func appendNewLanguage(_ language: LanguageBind, currentLanguage: LanguageBind, forUser user: User) -> Observable<Void> {
        let userReferance = database.collection(.databaseUserCollection).document(user.uid)
        let languagesReferance = userReferance.collection(.databaseLanguagesCollection).document(language.stringRepresentation)
        let languagesData = user.languages.value.map{ $0.stringRepresentation }
        
        return Observable<Void>.create { [weak self] (observer) -> Disposable in
            self?.database.runTransaction({ (transaction, errorPointer) -> Any? in
                    transaction.updateData(["languages": languagesData], forDocument: userReferance)
                    transaction.updateData(["currentLanguage": currentLanguage.stringRepresentation], forDocument: userReferance)
                    transaction.setData(language.representation, forDocument: languagesReferance)
                return nil
            }, completion: { (object, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    func getCards(withLanguage language: LanguageBind, userId: String) -> Observable<[TranslateCard]> {
        database
            .collection(.databaseUserCollection)
            .document(userId)
            .collection(.databaseLanguagesCollection)
            .document(language.stringRepresentation)
            .collection(.databaseCardsCollection)
            .rx
            .getDocuments()
            .map { (snapshot) -> [TranslateCard] in
                var cards = Array<TranslateCard>()
                snapshot.documents.forEach{
                    guard let card = TranslateCard(withData: $0.data()) else { return }
                    cards.append(card)
                }
                return cards }
    }
    
    // MARK: - Errors
    enum FirestoreError: Error {
        case languageExisted
    }
}
