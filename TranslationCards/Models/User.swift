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
    fileprivate (set) var uid: String
    fileprivate (set) var currentLanguage: Language?
    fileprivate (set) var nativeLanguage: Language?
    fileprivate (set) var email: String?
    fileprivate (set) var displayName: String?
    fileprivate (set) var avatarUrl: String?
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Cash Properties
    // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
    fileprivate(set) var languages: BehaviorRelay<[LanguageBind]?> = .init(value: nil)
    /// playlists stored using LanguageBind key value.
    fileprivate(set) var playlists: BehaviorRelay<[LanguageBind: [Playlist]]?> = .init(value: nil)
    /// cardsList stored using Playlist  key value.
    fileprivate(set) var cardsList: BehaviorRelay<[Playlist: [TranslateCard]]?> = .init(value: nil)
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
            return Observable<User>.create { (observer) -> Disposable in
                observer.onNext(user)
                observer.onCompleted()
                return Disposables.create()
            }
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
    fileprivate func acceptRemoteData(_ data: [String: Any]) {
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
    
    fileprivate func updatePlaylists(forLanguage language: LanguageBind) {
        fetchPlaylists(forLanguage: language)
            .subscribe(onNext: { [weak self] (_) in
                debugPrint("Succesfull update playlist for user with id \(self?.uid ?? "Unknown ID") and language \(language)")
                }, onError: { [weak self] (error) in
                    debugPrint("Unsuccesfull update playlist for user with id \(self?.uid ?? "Unknown ID") and language \(language) with error \(error)")
            })
        .disposed(by: disposeBag)
    }
    
    fileprivate func updateLanguages() {
        fetchLanguages()
            .subscribe(onNext: { [weak self] (_) in
                debugPrint("Succesfull update languages for user with id \(self?.uid ?? "Unknown ID")")
            }, onError: { [weak self] (error) in
                debugPrint("Unsuccesfull update languages for user with id \(self?.uid ?? "Unknown ID") with error \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func updateCards(forPlaylist playlist: Playlist) {
        fetchCards(forPlaylist: playlist)
            .subscribe(onNext: { (_) in
                debugPrint("Succesfull update cards for playlist \(playlist.description)")
            }, onError: { (error) in
                debugPrint("Unsuccesfull update cards for playlist \(playlist.description) with error \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    enum UserModelError: Error {
        case suchLanguageAlreadyExists
        case languagesDoesNotContainNewCurrentLanguage
    }
}

enum UserWorkWithDatabaseErrors: Error {
    case userObjectDeallocated
}

// MARK: - Services access
extension User: ServicesAccessing {
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
    
    func fetchPlaylists(forLanguage language: LanguageBind) -> Observable<Void> {
        .create { [weak self] (observer) -> Disposable in
            guard let self = self else {
                observer.onError(UserWorkWithDatabaseErrors.userObjectDeallocated)
                return Disposables.create()
            }
            
            self.services
                .realTimeDatabase
                .getPlaylistList(userId: self.uid, language: language)
                .subscribe(onNext: { [weak self] (playlists) in
                    guard let self = self else { return }
                    var oldPlaylists = self.playlists.value ?? [:]
                    oldPlaylists[language] = playlists
                    self.playlists.accept(oldPlaylists)
                    observer.onNext(())
                    observer.onCompleted()
                    }, onError: { (error) in
                        observer.onError(error)
                })
                .disposed(by: self.disposeBag)
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
                .subscribe(onNext: { [weak self] (cards) in
                    guard let self = self else { return }
                    var oldCards = self.cardsList.value ?? [:]
                    oldCards[playlist] = cards
                    self.cardsList.accept(oldCards)
                    observer.onNext(())
                    observer.onCompleted()
                    }, onError: { (error) in
                        observer.onError(error)
                })
                .disposed(by: self.disposeBag)
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
                    guard let playlists = self?.playlists.value?[card.language] else {
                        return
                    }
                    let playlist = playlists.filter{ $0.id == card.playlistId}.first
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
                    guard let playlists = self?.playlists.value?[card.language] else {
                        return
                    }
                    let playlist = playlists.filter{ $0.id == card.playlistId}.first
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
    
    func updateNativeLanguage(newLanguage: Language) -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self, !(newLanguage ==? self.nativeLanguage) else {
                observer.onNext(())
                observer.onCompleted()
                return Disposables.create()
            }
            self.nativeLanguage = newLanguage
            self.services.realTimeDatabase.updateUser(withUserId: self.uid, withData: ["nativeLanguage": newLanguage.rawValue])
                .subscribe(onNext: { (_) in
                    observer.onNext(())
                    observer.onCompleted()
                }, onError: { [weak self] (error) in
                    self?.nativeLanguage = newLanguage
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
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
