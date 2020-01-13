//
//  WriteCardsSlideShowViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol WritePhraseSlideShowViewModelInput {
    var getCurrentCentralCellIndexPath: (() -> IndexPath?)? { set get }
    var editCardButtonTap: PublishSubject<Void> { get }
}

protocol WritePhraseSlideShowViewModelOutput {
    var cards: BehaviorRelay<[TranslateCard]> { get }
    var isReverseMode: BehaviorRelay<Bool> { get }
}

protocol WritePhraseSlideShowViewModelType {
    var input: WritePhraseSlideShowViewModelInput { get }
    var output: WritePhraseSlideShowViewModelOutput { get }
}

extension WritePhraseSlideShowViewModelType where Self:  WritePhraseSlideShowViewModelInput & WritePhraseSlideShowViewModelOutput {
    var input: WritePhraseSlideShowViewModelInput { self }
    var output: WritePhraseSlideShowViewModelOutput { self }
}

final class WritePhraseSlideShowViewModel: ViewModel<WritePhraseSlideShowRouter>, WritePhraseSlideShowViewModelInput, WritePhraseSlideShowViewModelOutput, WritePhraseSlideShowViewModelType {
    
    let cards: BehaviorRelay<[TranslateCard]>
    var getCurrentCentralCellIndexPath: (() -> IndexPath?)? = nil
    let editCardButtonTap = PublishSubject<Void>()
    let isReverseMode: BehaviorRelay<Bool>
    
    // MARK: - Private combine observables
    private var currentCardAndUser: Observable<(user: User, currentCard: TranslateCard)> {
        Observable
            .just(getCurrentCentralCellIndexPath?())
            .unwrap()
            .withLatestFrom(cards) { ($1, $0) }
            .map { cards, indexPath in return cards[indexPath.row] }
            .flatMap{
                User.user(withId: $0.userOwnerId)
                    .withLatestFrom(Observable.just($0)) { ($0, $1) }
            }
    }
    
    init(cards: [TranslateCard], withReverse: Bool = false) {
        self.cards = .init(value: cards)
        self.isReverseMode = .init(value: withReverse)
        super.init()
        
        editCardButtonTap
        .subscribe(onNext: { [weak self] (_) in
            self?.openEditCardController()
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func openEditCardController() {
        currentCardAndUser
            .subscribe(onNext: { [weak self] (user, selectedCard) in
                self?.router.route(to: .editCard(selectedCard, user: user))
                }, onError: { [weak self] error in
                    self?.errorHandler(description: "Failed open edit card screen.", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
}
