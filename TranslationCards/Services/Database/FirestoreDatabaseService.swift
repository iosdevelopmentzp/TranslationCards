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
    func saveCard(_ card: TranslateCard, cardLanguageIsCurrentLanguage isCurrentLanguage: Bool) -> Observable<Void> {
        let userReferance = database.collection(.databaseUserCollection).document(card.userOwnerId)
        let languageReferance = userReferance.collection(.databaseLanguagesCollection).document(card.language.id)
        let cardDocumentReferance = languageReferance.collection(.databaseCardsCollection).document(card.id)
            
        return Observable<Void>.create { [weak self] (observer) -> Disposable in
           
            let saveCardAction = {
                self?.database.runTransaction({ (transaction, errorPoint) -> Any? in
                    if isCurrentLanguage {
                        transaction.updateData(["currentLanguage": card.language.stringRepresentation],
                                               forDocument: userReferance)
                    }
                    transaction.setData(card.representation, forDocument: cardDocumentReferance)
                    return nil
                }) { (object, error) in
                    if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onNext(())
                        observer.onCompleted()
                    }
                }
            }
            
            let firstCreateLanguageThenSaveCard = {
                languageReferance.setData(card.language.representation) { (error) in
                    if let error = error {
                        observer.onError(error)
                        return
                    }
                    saveCardAction()
                }
            }
            
            languageReferance
                .rx
                .isDocumentExist()
                .subscribe(onNext: { (isExist) in
                    if isExist {
                        saveCardAction()
                    } else {
                        firstCreateLanguageThenSaveCard()
                    }
                }, onError: { (error) in
                    firstCreateLanguageThenSaveCard()
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
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
    
    func getCards(withLanguage language: LanguageBind, userId: String) -> Observable<[TranslateCard]> {
        database
            .collection(.databaseUserCollection)
            .document(userId)
            .collection(.databaseLanguagesCollection)
            .document(language.id)
            .collection(.databaseCardsCollection)
            .rx
            .getDocuments()
            .map { (snapshot) -> [TranslateCard] in
                var cards = Array<TranslateCard>()
                snapshot.documents.forEach{
                    guard var card = TranslateCard(withData: $0.data()) else { return }
                    card.id = $0.reference.documentID
                    cards.append(card)
                }
                return cards }
    }
    
    // MARK: - Errors
    enum FirestoreError: Error {
        case languageExisted
    }
}
