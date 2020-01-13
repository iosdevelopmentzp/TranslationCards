//
//  SignUpRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class SignUpRouter: Router {
    enum Router {
        case mainView
        case choosingLanguage(user: User)
    }
    
    func route(to type: Router) {
        switch type {
        case .mainView:
            pushMainView()
        case .choosingLanguage(let user):
            openChoosingLanguage(user: user)
        }
    }
    
    // MARK: - Private
    private func openChoosingLanguage(user: User) {
        guard let viewController = viewController,
            viewController.isTopOfNavigationStack else {
                return
        }
        let vc = Screens.choosingNativeLanguage(forUser: user)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushMainView() {
        guard let viewController = viewController,
            viewController.isTopOfNavigationStack else {
                return
        }
        let vc = Screens.mainScreen()
        viewController.navigationController?.setViewControllers([vc], animated: true)
    }
}
