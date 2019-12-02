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
    
    // MARK: - Private services
    private lazy var realTimeDatabase: DatabaseService = FirestoreDatabaseService()
    
    // MARK: - Public services
    lazy var credentials: CredentialsService = CredentialsServiceV1(database: realTimeDatabase)
    lazy var auth: AuthService = AuthServiceV1(credentials: credentials, database: realTimeDatabase)
    lazy var cardsService: CardsServiceV1 = CardsServiceV1(database: realTimeDatabase)
}
