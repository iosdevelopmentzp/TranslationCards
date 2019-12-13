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
        case mainView
        case signUp
        case choiceLanguage
    }
    
    func route(to type: Route) {
        switch type {
        case .mainView:
            routeToMainView()
        case .signUp:
            routeToSignUp()
        case .choiceLanguage:
            pushChoiceLanguage()
        }
    }
    
    // MARK: - Private
    private func pushChoiceLanguage() {
        guard let viewController = viewController, viewController.isTopOfNavigationStack  else {
                return
        }
        let vc = Screens.nativeLanguageChoise()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func routeToSignUp() {
        let signUpViewController = Screens.signUp()
        viewController?.navigationController?.pushViewController(signUpViewController,
                                                                 animated: true)
    }
    
    private func routeToMainView() {
        guard let viewController = viewController, viewController.isTopOfNavigationStack  else {
                return
        }
        let mainViewController = Screens.main()
        viewController.navigationController?.setViewControllers([mainViewController], animated: true)
    }
}
