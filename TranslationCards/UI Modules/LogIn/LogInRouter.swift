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
        case tryRouteToMainView
        case signUp
        case tyrRouteToChoosingLanguage(user: User)
    }
    
    func route(to type: Route) {
        switch type {
        case .tryRouteToMainView:
            tryRouteToMainView()
        case .signUp:
            routeToSignUp()
        case .tyrRouteToChoosingLanguage(let user):
            tryRouteToChoosingLanguage(user: user)
        }
    }
    
    // MARK: - Private
    private func tryRouteToChoosingLanguage(user: User) {
        guard let viewController = viewController, viewController.isTopOfNavigationStack  else {
                return
        }
        let vc = Screens.choosingNativeLanguage(forUser: user)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func routeToSignUp() {
        let signUpViewController = Screens.signUp()
        viewController?.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    private func tryRouteToMainView() {
        guard let viewController = viewController, viewController.isTopOfNavigationStack  else {
                return
        }
        let mainViewController = Screens.mainScreen()
        viewController.navigationController?.setViewControllers([mainViewController], animated: true)
    }
}
