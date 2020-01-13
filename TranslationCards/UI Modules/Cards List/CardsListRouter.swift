//
//  CardsListRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class CardsListRouter: Router {
    enum Route {
        case slideShow(cards: [TranslateCard], withReverse: Bool)
        case writeSlideShow(cards: [TranslateCard], withReverse: Bool)
        case cardView(card: TranslateCard, user: User)
        case selectPlaylist(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>)
    }
    
    func route(to type: Route) {
        switch type {
        case .writeSlideShow(let cards, let withReverse):
            let vc = Screens.writePhraseSlideShow(withCards: cards, withReverse: withReverse)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .slideShow(let cards, let withReverse):
            let vc = Screens.cardSlideShow(cards: cards, withReverse: withReverse)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .cardView(let card, let user):
            let vc = Screens.viewCard(withCard: card, user: user)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .selectPlaylist(let dataSource, let selected):
            viewController?.presentPlaylistSelectionMenu(dataSource: dataSource, selected: selected)
        }
    }
}
