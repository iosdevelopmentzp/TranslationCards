//
//  User.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class User {
    private (set) var uid: String
    private (set) var currentLanguage: Language?
    private (set) var nativeLanguage: Language?
    private (set) var email: String?
    private (set) var displayName: String?
    private (set) var avatarUrl: String?
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Cash Properties
    // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
    private(set) var languages: BehaviorRelay<[LanguageBind]?> = .init(value: nil)
    /// playlists stored using LanguageBind key value.
    private(set) var playlists: BehaviorRelay< Set<Playlist>?> = .init(value: nil)
    /// cardsList stored using Playlist  key value.
    private(set) var cardsList: BehaviorRelay<[Playlist: [TranslateCard]]?> = .init(value: nil)
    // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
    
    init(uid: String, email: String? = nil, username: String? = nil, avatarUrl: String? = nil) {
        self.uid = uid
        self.email = email
        self.displayName = username
        self.avatarUrl = avatarUrl
    }
    
    init?(withData data: [String: Any]) {
        guard let uid = data["uid"] as? String else {
            return nil
        }
        self.uid = uid
        self.email = data["email"] as? String
        self.displayName = data["displayName"] as? String
        self.avatarUrl = data["avatarUrl"] as? String
        if let currentLanguageString = data["currentLanguage"] as? String {
            self.currentLanguage = Language(rawValue: currentLanguageString)
        }
        
        if let nativeLanguageStr = data["nativeLanguage"] as? String,
            let nativeLanguage = Language(rawValue: nativeLanguageStr) {
            self.nativeLanguage = nativeLanguage
        }
    }
    
    // MARK: - Static methods
    static func user(withId id: String) -> Observable<User> {
        if let user = Services.shared.credentials.user.value,
            user.uid == id {
            return .just(user)
        } else {
            return Services
                .shared
                .realTimeDatabase
                .fetchUser(withUserId: id)
        }
    }
    
    static var currentUser: BehaviorRelay<User?> {
        return Services.shared.credentials.user
    }
    // MARK: - Private
    private func acceptRemoteData(_ data: [String: Any]) {
        guard let uid = data["uid"] as? String,
                uid == self.uid else {
                return
        }
        self.email = data["email"] as? String
        self.displayName = data["displayName"] as? String
        self.avatarUrl = data["avatarUrl"] as? String
        if let currentLanguageString = data["currentLanguage"] as? String {
            self.currentLanguage = Language(rawValue: currentLanguageString)
        }
        
        if let nativeLanguageStr = data["nativeLanguage"] as? String,
            let nativeLanguage = Language(rawValue: nativeLanguageStr) {
            self.nativeLanguage = nativeLanguage
        }
    }
    
    
    enum UserModelError: Error {
        case suchLanguageAlreadyExists
        case languagesDoesNotContainNewCurrentLanguage
    }
}

extension User: DataRepresentation {
    var representation: [String : Any] {
        var data: [String : Any] = [:]
        data["uid"] = uid
        if let nativeLanguage = nativeLanguage { data["nativeLanguage"] = nativeLanguage.rawValue}
        if let currentLanguage = currentLanguage { data["currentLanguage"] = currentLanguage.rawValue}
        if let email = email { data["email"] = email }
        if let username = displayName { data["displayName"] = username }
        if let avatarUrl = avatarUrl { data["avatarUrl"] = avatarUrl }
        return data
    }
}

enum UserWorkWithDatabaseErrors: Error {
    case userObjectDeallocated
}

// MARK: - Services access
extension User {
    
    var services: Services { Services.shared }
    
    // Languages
    func fetchLanguages() -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(UserWorkWithDatabaseErrors.userObjectDeallocated)
                return Disposables.create()
            }
            self.services
                .realTimeDatabase
                .getLanguageList(forUserId: self.uid)
                .subscribe(onNext: { [weak self] (languages) in
                    self?.languages.accept(languages)
                    observer.onNext(())
                    observer.onCompleted()
                    }, onError: { [weak self] (error) in
                        debugPrint("Failed fetch languages list fo userId \(self?.uid ?? "Unknow ID")")
                        observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func updateNativeLanguage(newLanguage: Language) -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onNext(())
                observer.onCompleted()
                return Disposables.create()
            }
            guard !(newLanguage ==? self.nativeLanguage) else {
                self.services.credentials.acceptUser()
                observer.onNext(())
                observer.onCompleted()
                return Disposables.create()
            }
            self.nativeLanguage = newLanguage
            self.services.realTimeDatabase.updateUser(withUserId: self.uid, withData: ["nativeLanguage": newLanguage.rawValue])
                .subscribe(onNext: { [weak self] (_) in
                    self?.services.credentials.acceptUser()
                    observer.onNext(())
                    observer.onCompleted()
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    // Playlists
    func removePlaylistIfThereNoCards(playlist: Playlist) -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(UserWorkWithDatabaseErrors.userObjectDeallocated)
                return Disposables.create()}
            self.services
                .realTimeDatabase
                .removePlaylistIfThereAreNoCards(playlist)
                .subscribe(onNext: { [weak self] (_) in
                    observer.onNext(())
                    observer.onCompleted()
                    guard var oldPlaylists = self?.playlists.value else { return }
                    oldPlaylists.remove(playlist)
                    self?.playlists.accept(oldPlaylists)
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
        
    }
    
    func copyCardToAnotherPlaylist(card: TranslateCard, newPlaylistId: String) -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            self?.services
                .realTimeDatabase
                .copyCard(card, toAnotherPlaylistWithId: newPlaylistId)
                .subscribe(onNext: { [weak self] (_) in
                    observer.onNext(())
                    observer.onCompleted()
                    // refresh cards for playlists
                    self?.playlists.value?.filter{ $0.language == card.language }.forEach {
                        if $0.language == card.language && $0.id == newPlaylistId {
                            self?.updateCards(forPlaylist: $0)
                        }
                    }
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    func moveCardToAnotherPlaylist(card: TranslateCard, newPlaylistId: String) -> Observable<Void> {
        .create { [weak self] (observer) -> Disposable in
            let oldPlaylistId = card.playlistId
            self?.services.realTimeDatabase.movePlaylist(forCard: card, playlistForMoveId: newPlaylistId)
                .subscribe(onNext: { (_) in
                    observer.onNext(())
                    observer.onCompleted()
                    self?.playlists.value?.filter{ $0.language == card.language}.forEach {
                        if $0.id == oldPlaylistId || $0.id == newPlaylistId {
                            self?.updateCards(forPlaylist: $0)
                        }
                    }
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    func fetchPlaylists(forLanguage language: LanguageBind) -> Observable<[Playlist]> {
        .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(UserWorkWithDatabaseErrors.userObjectDeallocated)
                return Disposables.create()
            }
            
            self.services
                .realTimeDatabase
                .getPlaylistList(userId: self.uid, language: language)
                .subscribe(onNext: { [weak self] (playlists) in
                    self?.fetchedNewPlaylist(playlist: playlists, forLanguage: language)
                    observer.onNext(playlists)
                    observer.onCompleted()
                    }, onError: { (error) in
                        observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func getPlaylists(forLanguage language: LanguageBind) -> Observable<[Playlist]> {
        let userId = uid
        return Observable<[Playlist]>.create { [weak self] (observer) -> Disposable in
            self?.services.realTimeDatabase.getPlaylistList(userId: userId, language: language)
                .subscribe(onNext: { [weak self] (playlists) in
                    self?.fetchedNewPlaylist(playlist: playlists, forLanguage: language)
                    observer.onNext(playlists)
                    observer.onCompleted()
                    }, onError: { (error) in
                        observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    func addNewPlaylist(playlist: Playlist) -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            self?.services
                .realTimeDatabase
                .savePlaylist(playlist)
                .subscribe(onNext: { [weak self] (_) in
                    self?.fetchPlaylists(forLanguage: playlist.language)
                        .subscribe(onNext: { (_) in})
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                    observer.onNext(())
                    observer.onCompleted()
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
    // Cards
    func fetchCards(forPlaylists playlists: [Playlist]) -> Observable<Void> {
        .create { [weak self] (observer) -> Disposable in
            
            self?.services.realTimeDatabase.getCards(forPlaylists: playlists)
                .subscribe(onNext: { [weak self] (cards) in
                    observer.onNext(())
                    observer.onCompleted()
                    guard let self = self else { return }
                    var oldCardsDictionary = self.cardsList.value ?? [:]
                    playlists.forEach { currentPlaylist in
                        let currentPlaylistCards = cards.filter{ $0.playlistId == currentPlaylist.id}
                        oldCardsDictionary[currentPlaylist] = currentPlaylistCards
                    }
                    self.cardsList.accept(oldCardsDictionary)
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    func fetchCards(forPlaylist playlist: Playlist) -> Observable<Void> {
        .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(UserWorkWithDatabaseErrors.userObjectDeallocated)
                return Disposables.create()
            }
            
            self.services
                .realTimeDatabase
                .getCards(withPlaylist: playlist)
                .subscribe(onNext: { [weak self, weak playlist] (cards) in
                    observer.onNext(())
                    observer.onCompleted()
                    guard let self = self, let playlist = playlist else { return }
                    var oldCards = self.cardsList.value ?? [:]
                    oldCards[playlist] = cards
                    self.cardsList.accept(oldCards)
                    if cards.count <= 0 {
                        self.removePlaylistIfThereNoCards(playlist: playlist)
                            .subscribe()
                            .disposed(by: self.disposeBag)
                    }
                    }, onError: { (error) in
                        observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func saveCard(_ card: TranslateCard) -> Observable<Void> {
        card.updateOwnerUserId(newId: uid)
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(UserWorkWithDatabaseErrors.userObjectDeallocated)
                return Disposables.create()
            }
            self.services
                .realTimeDatabase
                .saveCard(card, cardLanguageIsCurrentLanguage: self.currentLanguage == nil)
                .subscribe(onNext: { [weak self] (_) in
                    observer.onNext(())
                    observer.onCompleted()
                    self?.updateLanguages()
                    self?.updatePlaylists(forLanguage: card.language)
                    guard let playlists = self?.playlists.value else {
                        return
                    }
                    let playlist = playlists.filter{ $0.language == card.language}.filter{ $0.id == card.playlistId}.first
                    guard let playlistForReload = playlist else {
                        return
                    }
                    self?.updateCards(forPlaylist: playlistForReload)
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func removeCard(_ card: TranslateCard) -> Observable<Void> {
        return .create {[weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(UserWorkWithDatabaseErrors.userObjectDeallocated)
                return Disposables.create()
            }
            guard card.userOwnerId == self.uid else {
                observer.onNext(())
                observer.onCompleted()
                return Disposables.create()
            }
            
            self.services
                .realTimeDatabase
                .removeCard(card)
                .subscribe(onNext: { [weak self] (_) in
                    observer.onNext(())
                    observer.onCompleted()
                    card.runtimeEvents.accept(.removed)
                    guard let playlists = self?.playlists.value else {
                        return
                    }
                    let playlist = playlists.filter{ $0.language == card.language}.filter{ $0.id == card.playlistId}.first
                    guard let playlistForReload = playlist else {
                        return
                    }
                    self?.updateCards(forPlaylist: playlistForReload)
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    // Common
    func synchronizeWithRemote() {
        services
            .realTimeDatabase
            .getUserData(userId: uid)
            .subscribe(onNext: { [weak self] (data) in
                self?.acceptRemoteData(data)
            }, onError: { [weak self] (error) in
                debugPrint("Unsuccesfull synchronize user \(self?.uid ?? "Unknow id") with remote data. Error \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func fetchedNewPlaylist(playlist: [Playlist], forLanguage language: LanguageBind) {
        var oldPlaylists = self.playlists.value ?? []
        playlist.forEach{ oldPlaylists.insert($0)}
        self.playlists.accept(oldPlaylists)
    }
    
    private func updatePlaylists(forLanguage language: LanguageBind) {
        fetchPlaylists(forLanguage: language)
            .subscribe(onNext: { [weak self] (_) in
                debugPrint("Succesfull update playlist for user with id \(self?.uid ?? "Unknown ID") and language \(language)")
                }, onError: { [weak self] (error) in
                    debugPrint("Unsuccesfull update playlist for user with id \(self?.uid ?? "Unknown ID") and language \(language) with error \(error)")
            })
        .disposed(by: disposeBag)
    }
    
    private func updateLanguages() {
        fetchLanguages()
            .subscribe(onNext: { [weak self] (_) in
                debugPrint("Succesfull update languages for user with id \(self?.uid ?? "Unknown ID")")
            }, onError: { [weak self] (error) in
                debugPrint("Unsuccesfull update languages for user with id \(self?.uid ?? "Unknown ID") with error \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    private func updateCards(forPlaylist playlist: Playlist) {
        fetchCards(forPlaylist: playlist)
            .subscribe(onNext: { (_) in
                debugPrint("Succesfull update cards for playlist \(playlist.description)")
            }, onError: { (error) in
                debugPrint("Unsuccesfull update cards for playlist \(playlist.description) with error \(error)")
            })
            .disposed(by: disposeBag)
    }
}
