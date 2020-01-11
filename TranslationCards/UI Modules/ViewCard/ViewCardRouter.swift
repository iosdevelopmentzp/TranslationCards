//
//  ViewCardRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class ViewCardRouter: Router {
    enum Route {
        case editCard(card: TranslateCard, user: User)
        case moveCardTo(dataSource: [Playlist], selected: Playlist, callback: PlaylistCallBack)
        case dismiss
    }
    
    func route(to type: Route) {
        switch type {
        case .editCard(let card, let user):
            presentEditCard(card, user: user)
        case .moveCardTo(let dataSource, let selected, let callback):
            viewController?.presentSingleChoicePlaylist(dataSource: dataSource, selectedAction: callback, currentSelect: selected)
        case .dismiss:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Private
    private func presentEditCard(_ card: TranslateCard, user: User) {
        let vc = Screens.editCard(forCard: card, user: user)
        viewController?.navigationController?.present(vc, animated: true, completion: nil)
    }
}
