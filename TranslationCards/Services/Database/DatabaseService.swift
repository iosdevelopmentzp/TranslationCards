//
//  DatabaseService.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift

protocol DatabaseService: Service {
    // MARK: - User
    func createUser(_ user: User) -> Observable<Void>
    func fetchUser(withUserId userId: String) -> Observable<User>
    func updateUser(withUserId userId: String, withData data: [String: Any]) -> Observable<Void>
    func deleteUser(withId userId: String) -> Observable<Void>
    func getUserData(userId: String) -> Observable<[String: Any]>
    
    // MARK: - Translate cards
    func removeCard(_ card: TranslateCard) -> Observable<Void>
    func saveCard(_ card: TranslateCard, cardLanguageIsCurrentLanguage isCurrentLanguage: Bool) -> Observable<Void>
    func getLanguageList(forUserId userId: String) -> Observable<[LanguageBind]>
    func getCards(withLanguage language: LanguageBind, playlistName: String,  userId: String) -> Observable<[TranslateCard]>
    func getCards(withPlaylist playlist: Playlist) -> Observable<[TranslateCard]>
    func getCards(forPlaylists playlists: [Playlist]) -> Observable<[TranslateCard]>
    
    // MARK: - Playlists
    func getPlaylistList(userId: String, language: LanguageBind) -> Observable<[Playlist]>
    func savePlaylist(_ playlist: Playlist) -> Observable<Void>
    func removePlaylist(_ playlist: Playlist) -> Observable<Void>
    func removePlaylistIfThereAreNoCards(_ playlist: Playlist) -> Observable<Void>
    func moveCard(_ card: TranslateCard, toPlaylistWithId newPlaylisitId: String) -> Observable<Void>
    func copyCard(_ card: TranslateCard, toAnotherPlaylistWithId newPlaylistId: String) -> Observable<Void>
}
