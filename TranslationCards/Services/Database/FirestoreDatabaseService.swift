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
        userDocumentReference(forUserId: user.uid).rx
            .setData(user.representation)
    }
    
    func fetchUser(withUserId userId: String) -> Observable<User> {
        return .create { [weak self] (observer) -> Disposable in
            self?.userDocumentReference(forUserId: userId).rx
                .getDocument()
                .subscribe(onNext: { (snapshot) in
                    guard let data = snapshot.data(),
                        let user = User(withData: data) else {
                            observer.onError(FirestoreError.failedCreateUserFromSnapshot)
                            return
                    }
                    observer.onNext(user)
                    observer.onCompleted()
                }, onError: { (error) in
                    observer.onError(error) })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    func updateUser(withUserId userId: String, withData data: [String: Any]) -> Observable<Void> {
        userDocumentReference(forUserId: userId).rx
            .updateData(data)
    }
    
    func deleteUser(withId userId: String) -> Observable<Void> {
        userDocumentReference(forUserId: userId).rx
            .delete()
    }
    
    func getUserData(userId: String) -> Observable<[String: Any]> {
        userDocumentReference(forUserId: userId)
        .rx
            .getDocument()
            .map { (snapshot) -> [String: Any] in
                return snapshot.data() ?? [:] }
    }
    
    // MARK: - Card
    func removeCard(_ card: TranslateCard) -> Observable<Void> {
        cardDocumentReference(forCard: card).rx
            .delete()
    }
    
    func saveCard(_ card: TranslateCard, cardLanguageIsCurrentLanguage isCurrentLanguage: Bool) -> Observable<Void> {
        
        if isCurrentLanguage {
            updateUser(withUserId: card.userOwnerId, withData: ["currentLanguage": card.language.targetLanguage.rawValue])
                .subscribe(onNext: { (_) in
                    debugPrint("Successfully updated current language")
                }, onError: { (error) in
                    debugPrint("Error! Unsuccesfull updated current language with error \(error)")
                })
            .disposed(by: disposeBag)
        }
        
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(FirestoreError.serviceDeallocated)
                return Disposables.create()
            }
            self.languageDocumentReference(forUserId: card.userOwnerId, language: card.language).rx
                .isDocumentExist()
                .subscribe(onNext: { (isExist) in
                    if isExist {
                        self.saveCard(card)
                        .bind(to: observer)
                            .disposed(by: self.disposeBag)
                    } else {
                        self.firstCreateLanguageDocumentThenSaveCard(card)
                        .bind(to: observer)
                            .disposed(by: self.disposeBag)
                    }
                }, onError: { (_) in
                    self.firstCreateLanguageDocumentThenSaveCard(card)
                    .bind(to: observer)
                        .disposed(by: self.disposeBag)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func getLanguageList(forUserId userId: String) -> Observable<[LanguageBind]> {
        userDocumentReference(forUserId: userId)
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
    
    func getCards(withLanguage language: LanguageBind, playlistName: String, userId: String) -> Observable<[TranslateCard]> {
        userDocumentReference(forUserId: userId)
            .collection(.databaseLanguagesCollection)
            .document(language.id)
            .collection(.databasePlaylistsCollection)
            .document(playlistName)
            .collection(.databaseCardsCollection)
            .rx
            .getDocuments()
            .map { (snapshot) -> [TranslateCard] in
                var cards = Array<TranslateCard>()
                snapshot.documents.forEach{
                    guard let card = TranslateCard(withData: $0.data()) else { return }
                    card.id = $0.reference.documentID
                    card.playlistId = playlistName
                    cards.append(card)
                }
                return cards }
    }
    
    func getCards(withPlaylist playlist: Playlist) -> Observable<[TranslateCard]> {
        cardsCollectionReferance(forPlaylist: playlist).rx
            .getDocuments()
            .map {(snapshot) -> [TranslateCard] in
                var cards = Array<TranslateCard>()
                snapshot.documents.forEach{
                    guard let card = TranslateCard(withData: $0.data()) else { return }
                    card.id = $0.reference.documentID
                    card.playlistId = playlist.id
                    cards.append(card)
                }
                return cards
        }
    }
    
    func getCards(forPlaylists playlists: [Playlist]) -> Observable<[TranslateCard]> {
        var cards: [TranslateCard] = []
        var oneOfError: Error? = nil
        return .create { (observer) -> Disposable in
            DispatchQueue.global(qos: .userInitiated).async {
                let downloadGroup = DispatchGroup()
                
                
                playlists.forEach { [weak self] in
                    downloadGroup.enter()
                    self?.getCards(withPlaylist: $0).subscribe(onNext: { (newCards) in
                        cards += newCards
                        downloadGroup.leave()
                    }, onError: { (error) in
                        oneOfError = error
                        downloadGroup.leave()
                    })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }
                
                downloadGroup.wait()
                if let error = oneOfError {
                    observer.onError(error)
                } else {
                    observer.onNext(cards)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
        
        
        
//        return .create { [weak self] (observer) -> Disposable in
//
//            self?.dispatchGroup.enter()
//
//            playlists.forEach { [weak self] in
//                self?.getCards(withPlaylist: $0)
//                    .subscribe(onNext: { (newCards) in
//                        cards += newCards
//                    }, onError: { (error) in
//                        observer.onError(error)
//                        withMistake = true
//                        self?.dispatchGroup.leave()
//                    })
//                    .disposed(by: self?.disposeBag ?? DisposeBag())
//            }
//
//            self?.dispatchGroup.notify(queue: .global(qos: .background), execute: {
//                if (!withMistake) {
//                    observer.onNext(cards)
//                    observer.onCompleted()
//                }
//            })
//
//            return Disposables.create()
//        }
    }
    
    // MARK: - Playlists
    func savePlaylist(_ playlist: Playlist) -> Observable<Void> {
        playlistDocumentReferance(forPlaylist: playlist).rx
            .setData(playlist.representation)
    }
    
    func removePlaylist(_ playlist: Playlist) -> Observable<Void> {
        playlistDocumentReferance(forPlaylist: playlist).rx
            .delete()
    }
    
    func getPlaylistList(userId: String, language: LanguageBind) -> Observable<[Playlist]> {
        userDocumentReference(forUserId: userId)
            .collection(.databaseLanguagesCollection)
            .document(language.id)
            .collection(.databasePlaylistsCollection)
            .rx
            .getDocuments()
            .map { (snapshot) -> [Playlist] in
                var playlists: Array<Playlist> = []
                snapshot.documents.forEach {
                    guard let playlist = Playlist(withData: $0.data()) else { return }
                    playlists.append(playlist)
                }
                return playlists
        }
    }
    
    func movePlaylist(forCard card: TranslateCard, playlistForMoveId: String) -> Observable<Void> {
        let oldCardReferance = cardDocumentReference(forCard: card)
        card.playlistId = playlistForMoveId
        let newCardReferance = cardDocumentReference(forCard: card)
        
        return .create { [weak self] (obsever) -> Disposable in
            self?.database.runTransaction({ (transaction, errorPoiner) -> Any? in
                transaction.deleteDocument(oldCardReferance)
                transaction.setData(card.representation, forDocument: newCardReferance)
                return nil
            }) { (_, error) in
                guard let error = error else {
                    obsever.onNext(())
                    obsever.onCompleted()
                    return
                }
                obsever.onError(error)
            }
            return Disposables.create()
        }
        
        
    }
    
    // MARK: - Private
    fileprivate func saveCard(_ card: TranslateCard) -> Observable<Void> {
        cardDocumentReference(forCard: card).rx
            .setData(card.representation)
    }
    
    fileprivate func firstCreateLanguageDocumentThenSaveCard(_ card: TranslateCard) -> Observable<Void> {
        .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(FirestoreError.serviceDeallocated)
                return Disposables.create()
            }
            self.languageDocumentReference(forUserId: card.userOwnerId, language: card.language).rx
                .setData(card.language.representation)
                .subscribe(onNext: { [weak self] (_) in
                    self?.saveCard(card)
                        .bind(to: observer)
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    // MARK: - Get references
    fileprivate func languageDocumentReference(forUserId userId: String, language: LanguageBind) -> DocumentReference {
        userDocumentReference(forUserId: userId)
            .collection(.databaseLanguagesCollection)
            .document(language.id)
    }
    
    fileprivate func userDocumentReference(forUserId userId: String) -> DocumentReference {
        database
            .collection(.databaseUserCollection)
            .document(userId)
    }
    
    fileprivate func cardsCollectionReferance(forPlaylist playlist: Playlist) -> CollectionReference {
        userDocumentReference(forUserId: playlist.userOwnerId)
            .collection(.databaseLanguagesCollection)
            .document(playlist.language.id)
            .collection(.databasePlaylistsCollection)
            .document(playlist.id)
            .collection(.databaseCardsCollection)
    }
    
    fileprivate func playlistDocumentReferance(forPlaylist playlist: Playlist) -> DocumentReference {
            userDocumentReference(forUserId: playlist.userOwnerId)
            .collection(.databaseLanguagesCollection)
            .document(playlist.language.id)
            .collection(.databasePlaylistsCollection)
            .document(playlist.id)
    }
    
    fileprivate func playlistDocumentReferance(userId: String, language: LanguageBind, playlistId: String) -> DocumentReference {
            userDocumentReference(forUserId: userId)
            .collection(.databaseLanguagesCollection)
            .document(language.id)
            .collection(.databasePlaylistsCollection)
            .document(playlistId)
    }
    
    fileprivate func cardDocumentReference(forCard card: TranslateCard) -> DocumentReference {
        database
            .collection(.databaseUserCollection)
            .document(card.userOwnerId)
            .collection(.databaseLanguagesCollection)
            .document(card.language.id)
            .collection(.databasePlaylistsCollection)
            .document(card.playlistId)
            .collection(.databaseCardsCollection)
            .document(card.id)
    }
    
    // MARK: - Enums
    enum FirestoreError: Error {
        case languageExisted
        case serviceDeallocated
        case failedCreateUserFromSnapshot
    }
}
