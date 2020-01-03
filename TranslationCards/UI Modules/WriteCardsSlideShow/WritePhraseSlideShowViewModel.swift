//
//  WriteCardsSlideShowViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class WritePhraseSlideShowViewModel: ViewModel<WritePhraseSlideShowRouter> {
    
    let cardsDataSource: BehaviorRelay<[TranslateCard]>
    let reverseMode: BehaviorRelay<Bool>
    var getSelectedCellIndexPath: (() -> IndexPath?)? = nil
    
    init(cards: [TranslateCard], withReverse: Bool = false) {
        cardsDataSource = .init(value: cards)
        self.reverseMode = .init(value: withReverse) 
        super.init()
    }
    
    func bindWIthActionButtons(editCardEvent: ControlEvent<Void>) {
        editCardEvent
        .subscribe(onNext: { [weak self] (_) in
            self?.openEditCardController()
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func openEditCardController() {
        guard let indexPath = getSelectedCellIndexPath?() else { return }
        let card = cardsDataSource.value[indexPath.row]
        User.user(withId: card.userOwnerId)
            .subscribe(onNext: { [weak self] (user) in
                self?.router.route(to: .editCard(card, user: user))
            })
        .disposed(by: disposeBag)
    }
}
