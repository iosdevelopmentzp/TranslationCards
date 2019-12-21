//
//  CardSlideShowViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class CardSlideShowViewModel: ViewModel<CardSlideShowRouter> {
    var cards = BehaviorRelay<[TranslateCard]>.init(value: [])
    let cellSpeechData = BehaviorRelay<SpeechData?>.init(value: nil)
    var getSelectedCellIndexPath: (() -> IndexPath?)? = nil
    
    init(cards: [TranslateCard]) {
        let isShuffle = arc4random() % 2 == 0 ? true : false
        if isShuffle {
            let shuffleArray = cards.shuffled()
            self.cards.accept(shuffleArray)
        } else {
            self.cards.accept(cards)
        }
        super.init()
        binding()
    }
    
    func viewDisappeared() {
        services.speechService.stopSpeaking()
    }
    
    func bindWIthActionButtons(editCardEvent: ControlEvent<Void>, moveCardToEvent: ControlEvent<Void>) {
        editCardEvent
            .subscribe(onNext: { [weak self] (_) in
                self?.openEditCardController()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func openMoveCardToController() {
        
    }
    
    fileprivate func openEditCardController() {
        guard let indexPath = getSelectedCellIndexPath?() else { return }
        let card = cards.value[indexPath.row]
        User.user(withId: card.userOwnerId)
            .subscribe(onNext: { [weak self] (user) in
                self?.router.route(to: .editCard(card, user: user))
            })
        .disposed(by: disposeBag)
    }
    
    fileprivate func binding() {
        cellSpeechData
            .compactMap{$0}
            .subscribe(onNext: { [weak self]  (speechData) in
                self?.services.speechService.speakText(speechData)
            })
            .disposed(by: disposeBag)
    }
    
}
