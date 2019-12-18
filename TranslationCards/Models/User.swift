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
    private (set) var currentLanguage: Language? {
        didSet {
            guard let language = currentLanguage else {
                return
            }
            debugPrint("Changed current language \(language)")
        }
    }
    private (set) var nativeLanguage: Language?
    private (set) var email: String?
    private (set) var displayName: String?
    private (set) var avatarUrl: String?
    
    private var disposeBag = DisposeBag()
    
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
    
    // MARK: - Private
    func updateNativeLanguage(newLanguage: Language) -> Observable<Void> {
        return .create { [weak self] (observer) -> Disposable in
            guard let self = self, !(newLanguage ==? self.nativeLanguage) else {
                observer.onNext(())
                observer.onCompleted()
                return Disposables.create()
            }
            self.nativeLanguage = newLanguage
            self.database.updateUser(withUserId: self.uid, withData: ["nativeLanguage": newLanguage.rawValue])
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
    
    // MARK: - Static methods
    static func user(withId id: String) -> Observable<User?> {
        if let user = Services.shared.credentials.user.value,
            user.uid == id {
            return Observable<User?>.create { (observer) -> Disposable in
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
    
    enum UserModelError: Error {
        case suchLanguageAlreadyExists
        case languagesDoesNotContainNewCurrentLanguage
    }
}

extension User: DatabaseServiceAccessing {
   
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
