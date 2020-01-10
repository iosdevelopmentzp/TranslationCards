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

protocol CardsListViewModelInput {
    var didSelectItem: PublishSubject<IndexPath> { get }
    var needDeleteItem: PublishSubject<IndexPath> { get }
    var shuffleMode: BehaviorRelay<Bool> { get }
    var reverseMode: BehaviorRelay<Bool> { get }
    var startSlideShow: PublishSubject<Void> { get }
    var startWhritePhraseSlideShow: PublishSubject<Void> { get }
    var openPlaylistsChoice: PublishSubject<Void> { get }
    var setEditMode: PublishSubject<Bool> { get }
}

protocol CardsListViewModelOutput {
    var sections: BehaviorRelay<[CardsListViewModelSection]> { get }
    var isRefreshing: BehaviorRelay<Bool> { get }
    var titleText: BehaviorRelay<String> { get }
    var isEditMode: BehaviorRelay<Bool> { get }
}

protocol CardsListViewModelType {
    var input: CardsListViewModelInput { get }
    var output: CardsListViewModelOutput { get }
}

extension CardsListViewModelType where Self: CardsListViewModelInput & CardsListViewModelOutput {
    var input: CardsListViewModelInput { self }
    var output: CardsListViewModelOutput { self }
}

final class CardsListViewModel: ViewModel<CardsListRouter>, CardsListViewModelInput, CardsListViewModelOutput, CardsListViewModelType {
    let didSelectItem = PublishSubject<IndexPath>()
    let needDeleteItem = PublishSubject<IndexPath>()
    let shuffleMode = BehaviorRelay<Bool>.init(value: false)
    let reverseMode = BehaviorRelay<Bool>.init(value: false)
    let startSlideShow = PublishSubject<Void>()
    let startWhritePhraseSlideShow = PublishSubject<Void>()
    let openPlaylistsChoice = PublishSubject<Void>()
    var setEditMode = PublishSubject<Bool>()
    
    let isRefreshing = BehaviorRelay<Bool>.init(value: true)
    let sections: BehaviorRelay<[CardsListViewModelSection]> = BehaviorRelay(value: [])
    let titleText = BehaviorRelay<String>.init(value: "")
    let isEditMode = BehaviorRelay<Bool>.init(value: false)
    
    fileprivate let user: User
    fileprivate let language: BehaviorRelay<LanguageBind>
    fileprivate let playlists: BehaviorRelay<[Playlist]> = .init(value: [])
    fileprivate let selectedPlaylists: BehaviorRelay<[Playlist]> = .init(value: [])
    
    // Custom observables
    fileprivate var playlistsInput: Observable<[Playlist]?> {
        return Observable.combineLatest(self.user.playlists.asObservable(), self.language.asObservable()) {
            guard let playlists = $0 else { return nil }
            let language = $1
            let newPlaylists = playlists.filter{ $0.language == language}
            return (Array(newPlaylists))
        }
    }
    
    fileprivate var cardsInput: Observable<[TranslateCard]?> {
        return Observable.combineLatest(self.user.cardsList, self.selectedPlaylists) {
            guard let cards = $0 else { return nil }
            let selectedPlaylists = $1
            let needCards = cards.filter { (keyPlaylist, valueCards) -> Bool in
                selectedPlaylists.contains(keyPlaylist)
            }
            return Array(needCards.values).joined().map{ $0 }
        }
    }
    
    init(language: LanguageBind, user: User) {
        self.user = user
        self.language = .init(value: language)
        super.init()
        
        titleText.accept("\(language.sourceLanguage) to \(language.targetLanguage)")
        
        isRefreshing
            .filter{ $0 == true}
            .subscribe(onNext: { [weak self] (_) in
                self?.fetchCards()
            })
            .disposed(by: disposeBag)
        
        cardsInput
            .unwrap()
            .subscribe(onNext: { [weak self] (newCards) in
                self?.updateSectionWithCards(newCards)
            })
            .disposed(by: disposeBag)
        
        playlistsInput
            .unwrap()
            .filter { [weak self] (newPlaylists) -> Bool in
                guard let self = self else { return false }
                return newPlaylists != self.selectedPlaylists.value }
            .bind(to: playlists)
            .disposed(by: disposeBag)
        
        playlists
            .withLatestFrom(selectedPlaylists)
            .filter{ $0.count == 0}
            .withLatestFrom(playlists)
            .map{ $0.randomElement()}
            .unwrap()
            .map{ [$0] }
            .bind(to: selectedPlaylists)
            .disposed(by: disposeBag)
        
        selectedPlaylists
            .filter{ $0.count > 0 }
            .subscribe(onNext: { [weak self] (playlists) in
                self?.fetchCards()
            })
            .disposed(by: disposeBag)
            
        didSelectItem
            .map{ [weak self] in
                self?.sections.value[$0.section].items[$0.row].item }
            .unwrap()
            .subscribe(onNext: { [weak self] (card) in
                guard let self = self else { return }
                self.router.route(to: .cardView(card: card, user: self.user))
            })
            .disposed(by: disposeBag)
        
        needDeleteItem
            .map{ [weak self] in
                self?.sections.value[$0.section].items[$0.row].item }
            .unwrap()
            .subscribe(onNext: { [weak self] (card) in
                self?.needDeleteCard(card)
            })
            .disposed(by: disposeBag)
        
        shuffleMode
            .distinctUntilChanged()
            .skip(1)
            .withLatestFrom(sections)
            .compactMap{
                $0.first?.items.map{ $0.item } }
            .subscribe(onNext: { [weak self] (cards) in
                self?.updateSectionWithCards(cards)
            })
            .disposed(by: disposeBag)
            
        startSlideShow
            .withLatestFrom(sections)
            .compactMap{ $0.first?.items.map{ $0.item } }
            .filter{ $0.count > 0}
            .subscribe(onNext: { [weak self] (cards) in
                self?.router.route(to: .slideShow(cards: cards, withReverse: self?.reverseMode.value ?? false))
            })
            .disposed(by: disposeBag)
        
        startWhritePhraseSlideShow
            .withLatestFrom(sections)
            .compactMap{ $0.first?.items.map{ $0.item } }
            .filter{ $0.count > 0}
            .subscribe(onNext: { [weak self] (cards) in
                self?.router.route(to: .writeSlideShow(cards: cards, withReverse: self?.reverseMode.value ?? false))
            })
            .disposed(by: disposeBag)
        
        openPlaylistsChoice
            .withLatestFrom(playlists)
            .filter{ $0.count > 0 }
            .subscribe(onNext: { [weak self] (playlists) in
                guard let self = self else { return }
                self.router.route(to: .selectPlaylist(dataSource: playlists,
                                                      selected: self.selectedPlaylists))
            })
            .disposed(by: disposeBag)
        
        setEditMode
            .bind(to: isEditMode)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func sortCards(_ cards: [TranslateCard]) -> [TranslateCard] {
        guard shuffleMode.value == false else {
            return cards.shuffled()
        }
        var sortedCards: Array<TranslateCard> = []
        let isReverse = reverseMode.value
        #if DEBUG
        sortedCards = cards.sorted(by: {
            if !isReverse {
                return $0.sourcePhrase.trimmingCharacters(in: .whitespaces) < $1.sourcePhrase.trimmingCharacters(in: .whitespaces)
            } else {
                return $0.targetPhrase.trimmingCharacters(in: .whitespaces) < $1.targetPhrase.trimmingCharacters(in: .whitespaces)
            }
        })
        #else
        sortedCards = cards.sorted(by: { $0.dateCreated.timeIntervalSince1970 < $1.dateCreated.timeIntervalSince1970 })
        #endif
        return sortedCards
    }
    
    fileprivate func updateSectionWithCards(_ cards: [TranslateCard]) {
        let sortedCards = sortCards(cards)
        let section = sections.value.first ?? CardsListViewModelSection(header: "Cards", items: [])
        let items = sortedCards.map{ CardsListViewModelCell.init(item: $0)}
        let newSection = CardsListViewModelSection(original: section, items: items)
        sections.accept([newSection])
    }
    
    fileprivate func needDeleteCard(_ card: TranslateCard) {
        startActivityIndicator.accept(true)
        
        user.removeCard(card)
            .catchError { [weak self] (error) -> Observable<()> in
                self?.errorHandler(description: "Failed delete card \(card.sourcePhrase)", error: error, withAlert: true)
                return .just(()) }
            .map{ false }
            .bind(to: startActivityIndicator)
            .disposed(by: disposeBag)
    }
    
    fileprivate func fetchCards() {
        
        if isRefreshing.value != true {
            isRefreshing.accept(true)
        }
        
        Observable.combineLatest(
            user.fetchCards(forPlaylists: selectedPlaylists.value),
            user.fetchPlaylists(forLanguage: language.value)
        )
            .ignoreAll()
            .catchError { [weak self] (error) -> Observable<Void> in
                self?.errorHandler(description: "Failed update data", error: error, withAlert: true)
                return .just(()) }
            .map{ false }
            .bind(to: isRefreshing)
        .disposed(by: disposeBag)
    }
}
