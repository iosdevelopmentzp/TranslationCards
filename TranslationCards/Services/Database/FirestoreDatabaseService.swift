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

final class FirestoreDatabaseService: NSObject, DatabaseService {
    
    private let database = Firestore.firestore()

    // MARK: - User
    func createUser(_ user: User) -> Observable<Void> {
        userDocumentReference(forUserId: user.uid)
            .rx
            .setData(user.representation)
    }
    
    func fetchUser(withUserId userId: String) -> Observable<User> {
        return userDocumentReference(forUserId: userId)
            .rx
            .getDocument()
            .flatMap { snapshot -> Observable<User> in
                guard let data = snapshot.data(), let user = User(withData: data) else {
                    return .error(FirestoreError.failedCreateUserFromSnapshot)
                }
                return .just(user)
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
        let languageReference = languageDocumentReference(forUserId: card.userOwnerId, language: card.language)
        let cardReferance = cardDocumentReference(forCard: card)
        return languageReference.rx
            .isDocumentExist()
            .flatMap{ isExist -> Observable<Void> in
                guard isExist else {
                    // first create language document
                    return languageReference.rx.setData(card.language.representation)}
                return .just(()) }
            .flatMap { (_) in
                return cardReferance.rx.setData(card.representation) }
            .flatMap{ [weak self] (_) -> Observable<Void> in
                guard isCurrentLanguage else { return .just(())}
                guard let self = self else { return .just(())}
                // update user current language value
                return self.updateUser(withUserId: card.userOwnerId, withData: ["currentLanguage": card.language.targetLanguage.rawValue]) }
    }
    
    func getLanguageList(forUserId userId: String) -> Observable<[LanguageBind]> {
        userDocumentReference(forUserId: userId)
            .collection(.databaseLanguagesCollection)
            .rx
            .getDocuments()
            .map{ $0.documents.compactMap{ LanguageBind(withString: $0.documentID) } }
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
                snapshot.documents.compactMap {
                    guard let card = TranslateCard(withData: $0.data()) else { return nil}
                    card.id = $0.reference.documentID
                    card.updatePlaylistID(playlistName)
                    return card
                }}
    }
    
    func getCards(withPlaylist playlist: Playlist) -> Observable<[TranslateCard]> {
        cardsCollectionReferance(forPlaylist: playlist).rx
            .getDocuments()
            .map { (snapshot) -> [TranslateCard] in
                snapshot.documents.compactMap {
                    guard let card = TranslateCard(withData: $0.data()) else { return nil}
                    card.id = $0.reference.documentID
                    card.updatePlaylistID(playlist.id)
                    return card
                }}
    }
    
    func getCards(forPlaylists playlists: [Playlist]) -> Observable<[TranslateCard]> {
        let observables = playlists.compactMap { [weak self] currentPlaylist ->  Observable<[TranslateCard]>? in
            guard let self = self else { return nil }
            return self.getCards(withPlaylist: currentPlaylist)
        }
        
        return Observable.zip(observables)
            .map{ $0.reduce([], +) }
    }
    
    // MARK: - Playlists
    func removePlaylistIfThereAreNoCards(_ playlist: Playlist) -> Observable<Void> {
        let playlistDocRef = playlistDocumentReferance(forPlaylist: playlist)
        let playlistCardCollection = cardsCollectionReferance(forPlaylist: playlist)
        return playlistCardCollection
            .rx
            .getDocuments()
            .filter{ $0.documents.count == 0 }
            .flatMap { (_) in
                return playlistDocRef.rx.delete() }
    }
    
    func savePlaylist(_ playlist: Playlist) -> Observable<Void> {
        let languageDocRef = languageDocumentReference(forUserId: playlist.userOwnerId, language: playlist.language)
        let playlistDocRef = playlistDocumentReferance(forPlaylist: playlist)
        
        return languageDocRef
            .rx
            .isDocumentExist()
            .flatMap { (isExist) -> Observable<Void> in
                guard isExist else {
                    return languageDocRef.rx.setData(playlist.language.representation)
                }
                return .just(())}
            .flatMap { (_) in
                return playlistDocRef.rx.setData(playlist.representation)
        }
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
            .map{ $0.documents.compactMap{ Playlist(withData: $0.data() ) } }
    }
    
    func moveCard(_ card: TranslateCard, toPlaylistWithId newPlaylisitId: String) -> Observable<Void> {
        let oldCardReferance = cardDocumentReference(forCard: card)
        card.updatePlaylistID(newPlaylisitId)
        let newCardReferance = cardDocumentReference(forCard: card)
        
        return  database.rx
            .runTransaction { (transaction) -> Any? in
                transaction.deleteDocument(oldCardReferance)
                transaction.setData(card.representation, forDocument: newCardReferance)
                return nil }
            .ignoreAll()
    }
    
    func copyCard(_ card: TranslateCard, toAnotherPlaylistWithId newPlaylistId: String) -> Observable<Void> {
        let newCard = TranslateCard(userId: card.userOwnerId, language: card.language, sourcePhrase: card.sourcePhrase, targetPhrase: card.targetPhrase)
        newCard.updatePlaylistID(newPlaylistId)
        return cardDocumentReference(forCard: newCard).rx.setData(newCard.representation)
    }
    
    // MARK: - Get documents and collections references
    private func languageDocumentReference(forUserId userId: String, language: LanguageBind) -> DocumentReference {
        userDocumentReference(forUserId: userId)
            .collection(.databaseLanguagesCollection)
            .document(language.id)
    }
    
    private func userDocumentReference(forUserId userId: String) -> DocumentReference {
        database
            .collection(.databaseUserCollection)
            .document(userId)
    }
    
    private func cardsCollectionReferance(forPlaylist playlist: Playlist) -> CollectionReference {
        userDocumentReference(forUserId: playlist.userOwnerId)
            .collection(.databaseLanguagesCollection)
            .document(playlist.language.id)
            .collection(.databasePlaylistsCollection)
            .document(playlist.id)
            .collection(.databaseCardsCollection)
    }
    
    private func playlistDocumentReferance(forPlaylist playlist: Playlist) -> DocumentReference {
            userDocumentReference(forUserId: playlist.userOwnerId)
            .collection(.databaseLanguagesCollection)
            .document(playlist.language.id)
            .collection(.databasePlaylistsCollection)
            .document(playlist.id)
    }
    
    private func playlistDocumentReferance(userId: String, language: LanguageBind, playlistId: String) -> DocumentReference {
            userDocumentReference(forUserId: userId)
            .collection(.databaseLanguagesCollection)
            .document(language.id)
            .collection(.databasePlaylistsCollection)
            .document(playlistId)
    }
    
    private func cardDocumentReference(forCard card: TranslateCard) -> DocumentReference {
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
        case languageNotCreated
        case languageExisted
        case failedCreateUserFromSnapshot
    }
}
