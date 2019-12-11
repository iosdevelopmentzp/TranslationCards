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
        case createCard(forUserId: String, language: LanguageBind?)
        case cardList(language: LanguageBind, userId: String)
    }
    
    func route(to type: Route) {
        switch type {
        case .createCard(let userId, let language):
            openCreateCardView(forUserId: userId, language: language)
        case .cardList(let language, let userId):
            openCardsList(language: language, userId: userId)
        }
    }
    
    // MARK: - Private
    fileprivate func openCreateCardView(forUserId userId: String, language: LanguageBind?) {
        let vc = Screens.createCard(forUserId: userId, language: language)
        viewController?.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    fileprivate func openCardsList(language: LanguageBind, userId: String) {
        let vc = Screens.cardsList(withLanguage: language, forUserId: userId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
