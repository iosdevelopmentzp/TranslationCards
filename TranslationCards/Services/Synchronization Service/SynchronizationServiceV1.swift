//
//  SynchronizationServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 15.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

struct Changes {
    let userId: String
    var typeOfChange: RealTimeEvents
    static func userId(_ id: String, typeOfChange: RealTimeEvents) -> Self {
        return Changes(userId: id, typeOfChange: typeOfChange)
    }
    static var empty: Self { return Changes(userId: "", typeOfChange: .nothing)}
}

enum RealTimeEvents {
    case changedUser
    case changedCardsList(inLanguage: LanguageBind, playlistId: String)
    case changedPlaylistsList(ofLanguage: LanguageBind)
    case changedLanguageLists
    case nothing
}

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
    
    let realTimeEvents = BehaviorRelay<Changes>.init(value: .empty)
    
    private let database: DatabaseService
    private let credentials: CredentialsService
    
    init(database: DatabaseService, credentials: CredentialsService) {
        self.database = database
        self.credentials = credentials
    }
    
    func synchronizeUserWithRemote(_ user: User) -> Observable<Void> {
        let change: Changes = .userId(user.uid, typeOfChange: .changedUser)
        return database
            .getUserData(userId: user.uid)
            .flatMap { [weak user] (data) -> Observable<Void> in
                if !(user?.acceptRemoteData(data) ?? false) {
                    return .error(SynchronizationServiceError.failedAttemptToSynchronizeUser(forUserId: user?.uid, receivedData: data))
                }
                return .just(()) }
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.realTimeEvents.accept(change) }
            .ignoreAll()
    }
    
    func fetchLanguages(forUserWithId userID: String) -> Observable<[LanguageBind]> {
        return database
            .getLanguageList(forUserId: userID)
    }
    
    func updateNativeLanguage(_ newLanguage: Language, forUser user: User) -> Observable<Void> {
        let userId = user.uid
        return database
            .updateUser(withUserId: user.uid, withData: ["nativeLanguage": newLanguage.rawValue])
            .execute { [weak self] in
                self?.realTimeEvents.accept(.userId(userId, typeOfChange: .changedUser)) }
    }
    
    func removePlaylistIfThereNoCards(playlist: Playlist) -> Observable<Void> {
        database
            .removePlaylistIfThereAreNoCards(playlist)
            .execute { [weak self] in
                self?.realTimeEvents.accept(.userId(playlist.userOwnerId, typeOfChange: .changedPlaylistsList(ofLanguage: playlist.language))) }
    }
    
    func copyCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void> {
        let change: Changes = .userId(card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: newPlaylistId))
        return database
            .copyCard(card, toAnotherPlaylistWithId: newPlaylistId)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.realTimeEvents.accept(change) }
            .ignoreAll()
    }
    
    func moveCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void> {
        let changeOld: Changes = .userId(card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: card.playlistId))
        let changeNew: Changes = .userId(card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: newPlaylistId))
        return database
            .moveCard(card, toPlaylistWithId: newPlaylistId)
            .withLatestFrom(Observable.just((changeOld, changeNew)))
            .execute { [weak self] (changeOld, changeNew) in
                self?.realTimeEvents.accept(changeOld)
                self?.realTimeEvents.accept(changeNew) }
            .ignoreAll()
    }
    
    func getPlaylists(forLanguage language: LanguageBind, userId: String) -> Observable<[Playlist]> {
        database
            .getPlaylistList(userId: userId, language: language)
    }
    
    func addNewPlaylist(playlist: Playlist) -> Observable<Void> {
        let change: Changes = .init(userId: playlist.userOwnerId, typeOfChange: .changedPlaylistsList(ofLanguage: playlist.language))
        return database
            .savePlaylist(playlist)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.realTimeEvents.accept(change)  }
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
        let change: Changes = .userId(card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: card.playlistId))
        return database
            .saveCard(card)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.realTimeEvents.accept(change)  }
            .ignoreAll()
    }
    
    func removeCard(_ card: TranslateCard) -> Observable<Void> {
        let change: Changes = .init(userId: card.userOwnerId, typeOfChange: .changedCardsList(inLanguage: card.language, playlistId: card.playlistId))
        return database
            .removeCard(card)
            .withLatestFrom(Observable.just(change))
            .execute { [weak self] (change) in
                self?.realTimeEvents.accept(change)  }
            .ignoreAll()
    }
}
