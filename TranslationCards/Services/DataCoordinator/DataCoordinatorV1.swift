//
//  SynchronizationServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 15.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class DataCoordinatorV1: DataCoordinator {
 
    enum DataCoordinatorError: LocalizedError {
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
                    return .error(DataCoordinatorError.failedAttemptToSynchronizeUser(forUserId: user?.uid, receivedData: data))
                }
                return .just(()) }
            .execute { [weak self] (_) in
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
            .execute { [weak self, weak user] (_) in
                user?.updateNativeLanguage(newLanguage: newLanguage)
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func copyCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void> {
        let change = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language.value, playlistId: newPlaylistId))
        return database
            .copyCard(card, toAnotherPlaylistWithId: newPlaylistId)
            .execute { [weak self] (_) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func moveCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void> {
        let changeOld = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language.value, playlistId: card.playlistId.value))
        let changeNew = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language.value, playlistId: newPlaylistId))
        return database
            .moveCard(card, toPlaylistWithId: newPlaylistId)
            .execute { [weak self] (_) in
                self?.listenerService.userСhangesListener.accept(changeOld)
                self?.listenerService.userСhangesListener.accept(changeNew) }
            .ignoreAll()
    }
    
    func removePlaylist(_ playlist: Playlist) -> Observable<Void> {
        let change = UserChanges(userId: playlist.userOwnerId,
                                 typeOfChange: .changedPlaylistsList(ofLanguage: playlist.language))
        return database
            .removePlaylist(playlist)
            .execute { [weak self] (_) in
                self?.listenerService.userСhangesListener.accept(change)
        }
    }
    
    func getPlaylists(forLanguage language: LanguageBind, userId: String) -> Observable<[Playlist]> {
        database
            .getPlaylistList(userId: userId, language: language)
    }
    
    func addNewPlaylist(playlist: Playlist) -> Observable<Void> {
        let change = UserChanges(userId: playlist.userOwnerId, typeOfChange: .changedPlaylistsList(ofLanguage: playlist.language))
        return database
            .savePlaylist(playlist)
            .execute { [weak self] (_) in
                self?.listenerService.userСhangesListener.accept(change) }
            .ignoreAll()
    }
    
    func fetchCards(forPlaylists playlists: [Playlist]) -> Observable<[TranslateCard]> {
        let observables = playlists.compactMap{ [weak self] in self?.fetchCards(forPlaylist: $0) }
        return Observable.zip(observables).map{ $0.reduce([], +) }
    }
    
    func fetchCards(forPlaylist playlist: Playlist) -> Observable<[TranslateCard]> {
        database
            .getCards(withPlaylist: playlist)
            .flatMap { [weak self] (cards) -> Observable<[TranslateCard]> in
                if cards.count == 0 {
                    return self?.removePlaylist(playlist).map{ cards } ?? .just(cards)
                }
                return .just(cards) }
    }
    
    func saveCard(_ card: TranslateCard) -> Observable<Void> {
        let userChange = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language.value, playlistId: card.playlistId.value))
        let cardChabge = CardChanges(cardId: card.id, typeOfChange: .changed)
        return database
            .saveCard(card)
            .execute { [weak self] (_) in
                self?.listenerService.userСhangesListener.accept(userChange)
                self?.listenerService.cardsChangesListener.accept(cardChabge)}
            .ignoreAll()
    }
    
    func removeCard(_ card: TranslateCard) -> Observable<Void> {
        let userChange = UserChanges(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language.value, playlistId: card.playlistId.value))
        let cardChange = CardChanges(cardId: card.id, typeOfChange: .removed)
        return database
            .removeCard(card)
            .execute { [weak self] (_) in
                self?.listenerService.userСhangesListener.accept(userChange)
                self?.listenerService.cardsChangesListener.accept(cardChange)
            }
            .ignoreAll()
    }
}
