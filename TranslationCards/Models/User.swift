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
    private (set) var nativeLanguage: Language
    private (set) var email: String?
    private (set) var displayName: String?
    private (set) var avatarUrl: String?
    
    init(uid: String, nativeLanguage: Language, email: String? = nil, username: String? = nil, avatarUrl: String? = nil) {
        self.uid = uid
        self.email = email
        self.displayName = username
        self.avatarUrl = avatarUrl
        self.nativeLanguage = nativeLanguage
    }
    
    init?(withData data: [String: Any]) {
        guard let uid = data["uid"] as? String,
              let nativeLanguageStr = data["nativeLanguage"] as? String,
              let nativeLanguage = Language(rawValue: nativeLanguageStr) else {
            return nil
        }
        self.uid = uid
        self.nativeLanguage = nativeLanguage
        self.email = data["email"] as? String
        self.displayName = data["displayName"] as? String
        self.avatarUrl = data["avatarUrl"] as? String
        if let currentLanguageString = data["currentLanguage"] as? String {
            self.currentLanguage = Language(rawValue: currentLanguageString)
        }
    }
    
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
        data["nativeLanguage"] = nativeLanguage.rawValue
        if let currentLanguage = currentLanguage { data["currentLanguage"] = currentLanguage.rawValue}
        if let email = email { data["email"] = email }
        if let username = displayName { data["displayName"] = username }
        if let avatarUrl = avatarUrl { data["avatarUrl"] = avatarUrl }
        return data
    }
}
