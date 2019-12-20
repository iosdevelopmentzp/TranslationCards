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
    
    let user: User
    let card: BehaviorRelay<TranslateCard>
    lazy var title = BehaviorRelay<String>.init(value: card.value.sourcePhrase)
    
    init(card: TranslateCard, user: User) {
        self.card = .init(value: card)
        self.user = user
        super.init()
    }
    
    func stopSpeach() {
        services.speechService.stopSpeaking()
    }
    
    func bind(speakData: BehaviorRelay<SpeechData?>) {
        speakData
            .compactMap{ $0 }
            .subscribe(onNext: { [weak self] (speakData) in
            self?.services.speechService.speakText(speakData)
        })
        .disposed(by: disposeBag)
    }
    
    func bind(editEvent: ControlEvent<Void>) {
        editEvent
            .subscribe(onNext: { [weak self] (_) in
                self?.stopSpeach()
                guard let self = self else { return }
                self.router.route(to: .editCard(card: self.card.value, user: self.user))
            })
            .disposed(by: disposeBag)
    }
}
