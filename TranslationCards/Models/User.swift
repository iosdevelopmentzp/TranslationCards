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
    private (set) var currentLanguage: LanguageBind?
    private (set) var languages = BehaviorRelay<[LanguageBind]>.init(value: [])
    private (set) var email: String?
    private (set) var displayName: String?
    private (set) var avatarUrl: String?
    
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
            self.currentLanguage = LanguageBind(withString: currentLanguageString)
        }
        if let languagesString = data["languages"] as? [String] {
            let languages = languagesString
                                .map { LanguageBind(withString: $0) }
                                .compactMap{$0}
            self.languages.accept(languages)
        }
    }
    
    enum UserModelError: Error {
        case suchLanguageAlreadyExists
        case languagesDoesNotContainNewCurrentLanguage
    }
}

extension User: DatabaseServiceAccessing {
    func appendLanguage(newLanguage: LanguageBind, andCurrentLanguage currentLanguage: LanguageBind) -> Observable<Void> {
        guard !languages.value.contains(newLanguage) else {
            return .error(User.UserModelError.suchLanguageAlreadyExists)
        }
        let newLanguages = languages.value + [newLanguage]
        languages.accept(newLanguages)
        return database.appendNewLanguage(newLanguage, currentLanguage: currentLanguage, forUser: self)
    }
    
    func setCurrentLanguageAndSend(currentLanguage: LanguageBind) -> Observable<Void> {
        guard languages.value.contains(currentLanguage) else {
            return .error(User.UserModelError.languagesDoesNotContainNewCurrentLanguage)
        }
        self.currentLanguage = currentLanguage
        return database.updateUser(withUserId: uid, withData: ["currentLanguage": currentLanguage.stringRepresentation])
    }
}

extension User: DataRepresentation {
    var representation: [String : Any] {
        var data: [String : Any] = [:]
        data["uid"] = uid
        if let currentLanguage = currentLanguage { data["currentLanguage"] = currentLanguage.stringRepresentation}
        if let email = email { data["email"] = email }
        if let username = displayName { data["displayName"] = username }
        if let avatarUrl = avatarUrl { data["avatarUrl"] = avatarUrl }
        if languages.value.count > 0 {
            data["languages"] = languages.value.map { $0.stringRepresentation }
        }
        return data
    }
}
