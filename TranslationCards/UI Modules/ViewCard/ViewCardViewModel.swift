//
//  ViewCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class ViewCardViewModel: ViewModel<ViewCardRouter> {
    
    let card: BehaviorRelay<TranslateCard>
    lazy var title = BehaviorRelay<String>.init(value: card.value.sourcePhrase)
    
    init(card: TranslateCard) {
        self.card = .init(value: card)
        super.init()
    }
    
    func bind(editEvent: ControlEvent<Void>) {
        editEvent
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.router.route(to: .editCard(card: self.card.value))
            })
            .disposed(by: disposeBag)
    }
}
