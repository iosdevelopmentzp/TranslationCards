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
        case slideShow(cards: [TranslateCard])
        case cardView(card: TranslateCard)
        case selectPlaylist(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>)
    }
    
    func route(to type: Route) {
        switch type {
        case .slideShow(let cards):
            pushSlideShow(cards: cards)
        case .cardView(let card):
            pushCardView(forCard: card)
        case .selectPlaylist(let dataSource, let selected):
            presentSelectPlaylistMenu(dataSource: dataSource, selected: selected)
        }
    }
    
    // MARK: - Private
    fileprivate func presentSelectPlaylistMenu(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>) {
        guard let sourceVC = viewController else { return }
        let menu = Screens.playlistSelectionMenu(dataSource: dataSource, selected: selected)
        menu.show(style: .present, from: sourceVC)
    }
    
    fileprivate func pushCardView(forCard card: TranslateCard) {
        let vc = Screens.viewCard(withCard: card)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func pushSlideShow(cards: [TranslateCard]) {
        let vc = Screens.cardSlideShow(cards: cards)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
