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
    
    init(cards: [TranslateCard]) {
        self.cards.accept(cards)
        super.init()
        binding()
    }
    
    func viewDisappeared() {
        services.speechService.stopSpeaking()
    }
    
    // MARK: - Private
    fileprivate func binding() {
        cellSpeechData
            .compactMap{$0}
            .subscribe(onNext: { [weak self]  (speechData) in
                self?.services.speechService.speakText(speechData)
            })
            .disposed(by: disposeBag)
    }
    
}
