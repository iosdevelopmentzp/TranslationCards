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
    
    func updateNativeLanguage(newLanguage: Language) {
        nativeLanguage = newLanguage
    }
    
    func acceptRemoteData(_ data: [String: Any]) -> Bool {
        guard let uid = data["uid"] as? String,
                uid == self.uid else {
                return false
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
        return true
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
