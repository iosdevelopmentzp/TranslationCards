//
//  CardsListViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CardsListViewModel: ViewModel<CardsListRouter> {
    var cardsDataSource = BehaviorRelay<[TranslateCard]>.init(value: [])
    var selectedItem: BehaviorRelay<IndexPath?> = .init(value: nil)
    
    lazy var titleText = Observable<String>.just("\(language.sourceLanguage) to \(language.targetLanguage)")
    
    fileprivate let language: LanguageBind
    fileprivate let userId: String
    
    init(language: LanguageBind, userId: String) {
        self.language = language
        self.userId = userId
        super.init()
        
        services.realTimeDatabase.getCards(withLanguage: language, userId: userId)
            .subscribe(onNext: { [weak self] (cards) in
                self?.cardsDataSource.accept(cards)
            }, onError: { [weak self] (error) in
                let wrongAlert = AlertModel.warningAlert(message: "Failed get cards list with error \(error)", handler: nil)
                self?.alertModel.accept(wrongAlert)
            })
            .disposed(by: disposeBag)
        
        selectedItem
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let indexPath = indexPath, let cards =  self?.cardsDataSource.value,
                    indexPath.row < cards.count, indexPath.row >= 0 else { return }
                let card = cards[indexPath.row]
                self?.router.route(to: .cardView(card: card))
            })
            .disposed(by: disposeBag)
    }
    
    func bindWith(startSlideShowButtonPressed startShowPressed: ControlEvent<Void>) {
        startShowPressed
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.router.route(to: .slideShow(cards: self.cardsDataSource.value)) })
            .disposed(by: disposeBag)
    }
}
