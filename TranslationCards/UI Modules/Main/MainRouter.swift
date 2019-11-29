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
        case createCard
    }
    
    func route(to type: Route) {
        switch type {
        case .createCard:
            openCreateCardView()
        }
    }
    
    // MARK: - Private
    fileprivate func openCreateCardView() {
        let vc = Screens.createCard()
        viewController?.navigationController?.present(vc, animated: true, completion: nil)
    }
}
