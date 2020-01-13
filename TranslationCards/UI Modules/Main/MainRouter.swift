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
        case cardList(language: LanguageBind, user: User)
    }
    
    func route(to type: Route) {
        switch type {
        case .cardList(let language, let user):
            let vc = Screens.cardsList(withLanguage: language, user: user)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
