//
//  MainNavigationRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class MainNavigationRouter: Router {
    
    enum Route {
        case createCard(user: User, language: LanguageBind)
    }
    
    func route(to type: Route) {
        switch type {
        case .createCard(let user, let language):
            let vc = Screens.createCard(forUser: user, withLanguage: language)
            viewController?.present(vc, animated: true, completion: nil)
        }
    }
}
