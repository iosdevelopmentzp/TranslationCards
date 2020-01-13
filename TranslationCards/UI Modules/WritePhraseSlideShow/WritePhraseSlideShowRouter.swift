//
//  WriteCardsSlideShowRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class WritePhraseSlideShowRouter: Router {
    enum Route {
        case editCard(_ card: TranslateCard, user: User)
    }
    
    func route(to type: Route) {
        switch type {
        case .editCard(let card, let user):
            let editVc = Screens.editCard(forCard: card, forUser: user)
            viewController?.navigationController?.present(editVc, animated: true, completion: nil)
        }
    }
}
