//
//  User.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class User {
    private (set) var uid: String
    private (set) var currentLanguage: LanguageBind
    private (set) var email: String?
    private (set) var displayName: String?
    private (set) var avatarUrl: String?
    
    init(uid: String, email: String? = nil, username: String? = nil, avatarUrl: String? = nil, currentLanguage: LanguageBind? = nil) {
        self.uid = uid
        self.email = email
        self.displayName = username
        self.avatarUrl = avatarUrl
        if let language = currentLanguage {
            self.currentLanguage = language
        } else {
            self.currentLanguage = LanguageBind(source: .rus, target: .eng)
        }
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
            self.currentLanguage = LanguageBind(withString: currentLanguageString) ?? LanguageBind.default
        } else { self.currentLanguage = LanguageBind.default}
    }
}

extension User: DataRepresentation {
    var representation: [String : Any] {
        var data: [String : Any] = [:]
        data["uid"] = uid
        data["currentLanguage"] = currentLanguage.stringRepresentation
        if let email = email { data["email"] = email }
        if let username = displayName { data["displayName"] = username }
        if let avatarUrl = avatarUrl { data["avatarUrl"] = avatarUrl }
        
        return data
    }
}
