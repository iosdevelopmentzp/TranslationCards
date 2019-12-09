//
//  Services.swift
//  ToDo
//
//  Created by krazke on 6/13/19.
//  Copyright © 2019 sowonderfultodo. All rights reserved.
//

final class Services {

    static let shared = Services()
    private init() {}
    
    // MARK: - Public services
    lazy var realTimeDatabase: DatabaseService = FirestoreDatabaseService()
    lazy var credentials: CredentialsService = CredentialsServiceV1(database: realTimeDatabase)
    lazy var auth: AuthService = AuthServiceV1(credentials: credentials, database: realTimeDatabase)
    lazy var speechService: SpeechService = SpeechServiceV1()
}
