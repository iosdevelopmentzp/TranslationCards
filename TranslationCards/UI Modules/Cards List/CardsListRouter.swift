//
//  CardsListRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class CardsListRouter: Router {
    enum Route {
        case slideShow(cards: [TranslateCard])
        case cardView(card: TranslateCard)
    }
    
    func route(to type: Route) {
        switch type {
        case .slideShow(let cards):
            pushSlideShow(cards: cards)
        case .cardView(let card):
            pushCardView(forCard: card)
        }
    }
    
    // MARK: - Private
    fileprivate func pushCardView(forCard card: TranslateCard) {
        let vc = Screens.viewCard(withCard: card)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func pushSlideShow(cards: [TranslateCard]) {
        let vc = Screens.cardSlideShow(cards: cards)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
