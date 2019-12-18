//
//  MainRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class MainRouter: Router {
    enum Route {
        case cardList(language: LanguageBind, userId: String)
    }
    
    func route(to type: Route) {
        switch type {
        case .cardList(let language, let userId):
            openCardsList(language: language, userId: userId)
        }
    }
    
    // MARK: - Private
    fileprivate func openCardsList(language: LanguageBind, userId: String) {
        let vc = Screens.cardsList(withLanguage: language, forUserId: userId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
