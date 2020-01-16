//
//  SynchronizationServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 15.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class SynchronizationServiceV1: SynchronizationService {
 
    enum SynchronizationServiceError: LocalizedError {
        case failedAttemptToSynchronizeUser(forUserId: String?, receivedData: [String: Any])
        
        var localizedDescription: String {
            switch self {
            case .failedAttemptToSynchronizeUser(let userId, let receivedData):
                return "Failed attempt to synchronize user \(userId ?? "no ID") with recieved data: \(receivedData)"
            }
        }
    }
    
    private let database: DatabaseService
    private let listenerService: ListenerService
    
    init(database: DatabaseService, listenerService: ListenerService) {
        self.database = database
        self.listenerService = listenerService
    }
    
    func synchronizeUserWithRemote(_ user: User) -> Observable<Void> {
        let change = UserChanges(userId: user.uid, typeOfChange: .changedUser)
        return database
            .getUserData(userId: user.uid)
            .flatMap { [weak user] (data) -> Observable<Void> in
                if !(user?.acceptRemoteData(data) ?? false) {
                    return .error(SynchronizationServiceError.failedAttemptToSynchronizeUser(forUserId: user?.uid, receivedData: data))
                }
                return .just(()) }
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func fetchLanguages(forUserWithId userID: String) -> Observable<[LanguageBind]> {
        return database
            .getLanguageList(forUserId: userID)
    }
    
    func updateNativeLanguage(_ newLanguage: Language, forUser user: User) -> Observable<Void> {
        let change = UserChanges(userId: user.uid, typeOfChange: .changedUser)
        return database
            .updateUser(withUserId: user.uid, withData: ["nativeLanguage": newLanguage.rawValue])
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func removePlaylistIfThereNoCards(playlist: Playlist) -> Observable<Void> {
        let change = UserChanges(userId: playlist.userOwnerId, typeOfChange: .changedPlaylistsList(ofLanguage: playlist.language))
        return database
            .removePlaylistIfThereAreNoCards(playlist)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func copyCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void> {
        let change = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: newPlaylistId))
        return database
            .copyCard(card, toAnotherPlaylistWithId: newPlaylistId)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func moveCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void> {
        let changeOld = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: card.playlistId))
        let changeNew = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: newPlaylistId))
        return database
            .moveCard(card, toPlaylistWithId: newPlaylistId)
            .withLatestFrom(Observable.just((changeOld, changeNew)))
            .execute { [weak self] (changeOld, changeNew) in
                self?.listenerService.userСhangesListener.accept(changeOld)
                self?.listenerService.userСhangesListener.accept(changeNew) }
            .ignoreAll()
    }
    
    func getPlaylists(forLanguage language: LanguageBind, userId: String) -> Observable<[Playlist]> {
        database
            .getPlaylistList(userId: userId, language: language)
    }
    
    func addNewPlaylist(playlist: Playlist) -> Observable<Void> {
        let change = UserChanges(userId: playlist.userOwnerId, typeOfChange: .changedPlaylistsList(ofLanguage: playlist.language))
        return database
            .savePlaylist(playlist)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func fetchCards(forPlaylists playlists: [Playlist]) -> Observable<[TranslateCard]> {
        database
            .getCards(forPlaylists: playlists)
    }
    
    func fetchCards(forPlaylist playlist: Playlist) -> Observable<[TranslateCard]> {
        database
            .getCards(withPlaylist: playlist)
    }
    
    func saveCard(_ card: TranslateCard) -> Observable<Void> {
        let change = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: card.playlistId))
        return database
            .saveCard(card)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func removeCard(_ card: TranslateCard) -> Observable<Void> {
        let userChange = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: card.playlistId))
        let cardChange = CardChanges(cardId: card.id, typeOfChange: .removed)
        return database
            .removeCard(card)
            .withLatestFrom(Observable.just((userChange, cardChange)))
            .execute { [weak self] (userChange, cardCahnge) in
                self?.listenerService.userСhangesListener.accept(userChange)
                self?.listenerService.cardsChangesListener.accept(cardChange)
            }
            .ignoreAll()
    }
}
