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

enum CardsListMode {
    case actual
    case archive
}

final class CardsListViewModel: ViewModel<CardsListRouter> {
    var cardsDataSource = BehaviorRelay<[TranslateCard]>.init(value: [])
    var selectedItem: BehaviorRelay<IndexPath?> = .init(value: nil)
    var mode: BehaviorRelay<CardsListMode>
    
    lazy var titleText: BehaviorRelay<String?> = .init(value: nil)
    
    fileprivate let language: LanguageBind
    fileprivate let userId: String
    
    init(language: LanguageBind, userId: String, mode: CardsListMode) {
        self.language = language
        self.userId = userId
        self.mode = .init(value: mode)
        super.init()
        
        updateTitle()
        fetchRemoteData()
        
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
    
    func bindWith(openArchivedList: ControlEvent<Void>) {
        openArchivedList
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.router.route(to: .archivedList(language: self.language, userId: self.userId))
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func updateTitle() {
        switch mode.value {
        case .actual:
            titleText.accept("\(language.sourceLanguage) to \(language.targetLanguage)")
        case .archive:
            titleText.accept("Archive of \(language.sourceLanguage.rawValue) to \(language.targetLanguage.rawValue)")
        }
    }
    
    fileprivate func fetchRemoteData() {
#warning("Uncomment later")
        /*
        var observer: Observable<[TranslateCard]>
        switch mode.value {
        case .actual:
            observer = services
                .realTimeDatabase
                .getCards(withLanguage: language, userId: userId)
        case .archive:
            observer = services
                .realTimeDatabase
                .getArchivedCards(withLanguage: language, userId: userId)
        }
        
        observer
            .subscribe(onNext: { [weak self] (cards) in
                self?.cardsDataSource.accept(cards)
                }, onError: { [weak self] (error) in
                    let wrongAlert = AlertModel.warningAlert(message: "Failed get cards list with error \(error)", handler: nil)
                    self?.alertModel.accept(wrongAlert)
            })
            .disposed(by: disposeBag)
 */
    }
}
