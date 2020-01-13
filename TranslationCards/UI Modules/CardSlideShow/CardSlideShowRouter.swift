//
//  CardSlideShowRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class CardSlideShowRouter: Router {
    
    enum Route {
        case editCard(_ card: TranslateCard, user: User)
        case choosingPlaylist(dataSource: [Playlist], selected: Playlist, callback: PlaylistCallBack)
    }
    
    func route(to type: Route) {
        switch type {
        case .editCard(let card, let user):
            let editVc = Screens.editCard(forCard: card, forUser: user)
            viewController?.navigationController?.present(editVc, animated: true, completion: nil)
        case .choosingPlaylist(let dataSource, let selected, let callback):
            viewController?.presentSingleChoicePlaylist(dataSource: dataSource, selectedAction: callback, currentSelect: selected)
        }
    }
}
