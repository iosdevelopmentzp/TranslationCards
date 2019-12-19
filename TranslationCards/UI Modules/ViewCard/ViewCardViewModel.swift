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
    
    init(card: TranslateCard) {
        self.card = .init(value: card)
        self.mode = card.isArchived ? .init(value: .archive) : .init(value: .actual)
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
                self.router.route(to: .editCard(card: self.card.value))
            })
            .disposed(by: disposeBag)
    }
    
    func bind(switchLocationEvent: ControlEvent<Void>) {
#warning("Uncomment later")
        /*
        switchLocationEvent
            .withLatestFrom(mode)
            .subscribe(onNext: { [weak self] (mode) in
                self?.stopSpeach()
                switch mode {
                case .actual:
                    self?.startActivityIndicator.accept(true)
                    self?.card
                        .value
                        .moveToArchive()
                        .subscribe(onNext: { (_) in
                            self?.router.route(to: .dismiss)
                            self?.startActivityIndicator.accept(false)
                        }, onError: { (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: nil))
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                case .archive:
                    self?.startActivityIndicator.accept(true)
                    self?.card
                        .value
                        .moveFromArchive()
                        .subscribe(onNext: { (_) in
                            self?.router.route(to: .dismiss)
                            self?.startActivityIndicator.accept(false)
                        }, onError: { (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: nil))
                        })
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                }
            })
            .disposed(by: disposeBag)
 */
    }
}
