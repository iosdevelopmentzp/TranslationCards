//
//  LogInRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class LogInRouter: Router {
    
    enum Route {
        case mainNavigation
        case signUp
    }
    
    func route(to type: Route) {
        switch type {
        case .mainNavigation:
            routeToMainNavigation()
        case .signUp:
            routeToSignUp()
        }
    }
    
    // MARK: - Private
    private func routeToSignUp() {
        let signUpViewController = Screens.signUp()
        viewController?.navigationController?.pushViewController(signUpViewController,
                                                                 animated: true)
    }
    
    private func routeToMainNavigation() {
        // TODO: - Make push main navigation
    }
}
