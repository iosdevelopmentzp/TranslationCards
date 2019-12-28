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
    
    init(cards: [TranslateCard], withReverse: Bool = false) {
        cardsDataSource = .init(value: cards)
        self.reverseMode = .init(value: withReverse) 
        super.init()
    }
}
