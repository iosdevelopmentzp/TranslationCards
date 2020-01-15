//
//  UserUpdaterService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 15.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

/// A service to which you can change the state of a user, save, delete, update cards, and so on. All data will be synchronized both locally and with the server. You can also receive all data through it.
protocol SynchronizationService: Service {
    var realTimeEvents: BehaviorRelay<Changes> { get }
    
    // user methods
    func synchronizeUserWithRemote(_ user: User) -> Observable<Void>
    
    // languages
    func fetchLanguages(forUserWithId userID: String) -> Observable<[LanguageBind]>
    func updateNativeLanguage(_ newLanguage: Language, forUser user: User) -> Observable<Void>
    
    // playlists
    func removePlaylistIfThereNoCards(playlist: Playlist) -> Observable<Void>
    func copyCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void>
    func moveCard(_ card: TranslateCard, toNewPlaylistId newPlaylistId: String) -> Observable<Void>
    func getPlaylists(forLanguage language: LanguageBind, userId: String) -> Observable<[Playlist]>
    func addNewPlaylist(playlist: Playlist) -> Observable<Void>
    
    // Cards
    func fetchCards(forPlaylists playlists: [Playlist]) -> Observable<[TranslateCard]>
    func fetchCards(forPlaylist playlist: Playlist) -> Observable<[TranslateCard]>
    func saveCard(_ card: TranslateCard) -> Observable<Void>
    func removeCard(_ card: TranslateCard) -> Observable<Void>
}
