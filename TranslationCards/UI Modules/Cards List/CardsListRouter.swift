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
            pushSlideShow(cards: cards, withReverse: withReverse)
        case .cardView(let card, let user):
            pushCardView(forCard: card, user: user)
        case .selectPlaylist(let dataSource, let selected):
            presentSelectPlaylistMenu(dataSource: dataSource, selected: selected)
        }
    }
    
    // MARK: - Private
    private func presentSelectPlaylistMenu(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>) {
        viewController?.presentPlaylistSelectionMenu(dataSource: dataSource, selected: selected)
    }
    
    private func pushCardView(forCard card: TranslateCard, user: User) {
        let vc = Screens.viewCard(withCard: card, user: user)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushSlideShow(cards: [TranslateCard], withReverse: Bool) {
        let vc = Screens.cardSlideShow(cards: cards, withReverse: withReverse)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
