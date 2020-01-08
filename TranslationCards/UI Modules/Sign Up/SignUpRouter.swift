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
        case back
        case mainView
        case choiceLanguage(user: User)
    }
    
    func route(to type: Router) {
        switch type {
        case .back:
            viewController?.navigationController?.popViewController(animated: true)
        case .mainView:
            pushMainView()
        case .choiceLanguage(let user):
            pushChoiseLanguage(user: user)
        }
    }
    
    // MARK: - Private
    fileprivate func pushChoiseLanguage(user: User) {
        guard let viewController = viewController,
            viewController.isTopOfNavigationStack else {
                return
        }
        let vc = Screens.nativeLanguageChoise(user: user)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func pushMainView() {
        guard let viewController = viewController,
            viewController.isTopOfNavigationStack else {
                return
        }
        let vc = Screens.main()
        viewController.navigationController?.setViewControllers([vc], animated: true)
    }
}
