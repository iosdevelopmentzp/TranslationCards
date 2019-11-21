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
    private (set) var email: String?
    private (set) var username: String?
    private (set) var avatarUrl: String?
    
    init(uid: String, email: String? = nil, username: String? = nil, avatarUrl: String? = nil) {
        self.uid = uid
        self.email = email
        self.username = username
        self.avatarUrl = avatarUrl
    }
}

extension User: DataRepresentation {
    var representation: [String : Any] {
        var data: [String : Any] = [:]
        data["uid"] = uid
        if let email = email { data["email"] = email }
        if let username = username { data["username"] = username }
        if let avatarUrl = avatarUrl { data["avatarUrl"] = avatarUrl }
        return data
    }
}
