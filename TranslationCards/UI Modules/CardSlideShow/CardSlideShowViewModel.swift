//
//  CardSlideShowViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxRelay

final class CardSlideShowViewModel: ViewModel<CardSlideShowRouter> {
    var cards = BehaviorRelay<[TranslateCard]>.init(value: [])
    
    init(cards: [TranslateCard]) {
        self.cards.accept(cards)
        super.init()
    }
    
    func bindWithDidEndDisplayingCellAtIndexPath(_ endDisplayingCell: Observable<IndexPath>) {
        endDisplayingCell
            .subscribe(onNext: { [weak self] (indexPath) in
//                guard indexPath.row == 0, var oldCards = self?.cards.value else { return }
//                oldCards.remove(at: indexPath.row)
//                self?.cards.accept(oldCards)
            })
            .disposed(by: disposeBag)
    }
}
