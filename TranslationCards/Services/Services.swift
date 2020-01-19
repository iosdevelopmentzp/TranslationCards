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
    
    // MARK: Private:
    private lazy var realTimeDatabase: DatabaseService = FirestoreDatabaseService()
    
    // MARK: - Public services
    lazy var userDefaults: KeyValueStorageService = UserDefaultsService()
    lazy var credentials: CredentialsService = CredentialsServiceV1(database: realTimeDatabase, keyStorage: userDefaults, dataCoordinator: dataCoordinator, listenerService: listenerService)
    lazy var auth: AuthService = AuthServiceV1(credentials: credentials, database: realTimeDatabase)
    lazy var speechService: SpeechService = SpeechServiceV1()
    lazy var translateService: TranslateService = MicrosoftAzureTranslateService()
    lazy var listenerService: ListenerService = ListenerServiceV1()
    lazy var dataCoordinator: DataCoordinator = DataCoordinatorV1(database: realTimeDatabase, listenerService: listenerService)
}
