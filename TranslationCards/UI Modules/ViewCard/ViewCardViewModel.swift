//
//  ViewCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

enum ViewCardMode {
    case actual
    case archive
}

final class ViewCardViewModel: ViewModel<ViewCardRouter> {
    
    let card: BehaviorRelay<TranslateCard>
    lazy var title = BehaviorRelay<String>.init(value: card.value.sourcePhrase)
    let mode: BehaviorRelay<ViewCardMode>
    
    init(card: TranslateCard, mode: ViewCardMode) {
        self.card = .init(value: card)
        self.mode = .init(value: mode) 
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
    
    func bind(switchLocationEvent: ControlEvent<Void>) {
        switchLocationEvent
            .withLatestFrom(mode)
            .subscribe(onNext: { [weak self] (mode) in
                switch mode {
                case .actual:
                    self?.card
                        .value
                        .moveToArchive()
                        .subscribe(onNext: { (_) in
                            self?.router.route(to: .dismiss)
                        }, onError: { (error) in
                            self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: nil))
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                case .archive:
                    self?.card
                        .value
                        .moveFromArchive()
                        .subscribe(onNext: { (_) in
                            self?.router.route(to: .dismiss)
                        }, onError: { (error) in
                            self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: nil))
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }
            })
            .disposed(by: disposeBag)
    }
}
