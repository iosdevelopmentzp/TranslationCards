//
//  MainNavigationRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class MainNavigationRouter: Router {
    
    enum Route {
        case createCard(forUserId: String, language: LanguageBind)
    }
    
    func route(to type: Route) {
        switch type {
        case .createCard(let userId, let language):
            openCreateCardView(forUserId: userId, language: language)
        }
    }
    
    // MARK: - Private
    fileprivate func openCreateCardView(forUserId userId: String, language: LanguageBind) {
        let vc = Screens.createCard(forUserId: userId, language: language)
        viewController?.present(vc, animated: true, completion: nil)
    }
}
