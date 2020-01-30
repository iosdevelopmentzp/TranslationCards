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
    
    private let user: User
    private let language: BehaviorRelay<LanguageBind>
    private let playlists: BehaviorRelay<[Playlist]> = .init(value: [])
    private let selectedPlaylists: BehaviorRelay<[Playlist]> = .init(value: [])
    
    init(language: LanguageBind, user: User) {
        self.user = user
        self.language = .init(value: language)
        super.init()
        
        titleText.accept("\(language.sourceLanguage) to \(language.targetLanguage)")
        
        isRefreshing
            .filter{ $0 == true}
            .subscribe(onNext: { [weak self] (_) in
                self?.fetchData()
            })
            .disposed(by: disposeBag)
        
        let userId = user.uid
        services.listenerService
            .userСhangesListener
            .filter{ $0.userId == userId }
            .subscribe(onNext: {[weak self] (change) in
                self?.receivedUserChanges(newChange: change.typeOfChange) })
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
                self?.deleteCard(card)
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
    private func sortCards(_ cards: [TranslateCard]) -> [TranslateCard] {
        guard shuffleMode.value == false else {
            return cards.shuffled()
        }
        var sortedCards: Array<TranslateCard> = []
//        let isReverse = reverseMode.value
//        #if DEBUG
//        sortedCards = cards.sorted(by: {
//            if !isReverse {
//                return $0.sourcePhrase.value.trimmingCharacters(in: .whitespaces) < $1.sourcePhrase.value.trimmingCharacters(in: .whitespaces)
//            } else {
//                return $0.targetPhrase.value.trimmingCharacters(in: .whitespaces) < $1.targetPhrase.value.trimmingCharacters(in: .whitespaces)
//            }
//        })
//        #else
        sortedCards = cards.sorted(by: { $0.dateCreated.timeIntervalSince1970 > $1.dateCreated.timeIntervalSince1970 })
//        #endif
        return sortedCards
    }
    
    private func updateSectionWithCards(_ cards: [TranslateCard]) {
        let sortedCards = sortCards(cards)
        let section = sections.value.first ?? CardsListViewModelSection(header: "Cards", items: [])
        let items = sortedCards.map{ CardsListViewModelCell.init(item: $0)}
        let newSection = CardsListViewModelSection(original: section, items: items)
        sections.accept([newSection])
    }
    
    private func deleteCard(_ card: TranslateCard) {
        startActivityIndicator.accept(true)
        
        services.dataCoordinator
            .removeCard(card)
            .catchError { [weak self] (error) -> Observable<()> in
                self?.errorHandler(description: "Failed delete card \(card.sourcePhrase)", error: error, withAlert: true)
                return .just(()) }
            .map{ false }
            .bind(to: startActivityIndicator)
            .disposed(by: disposeBag)
    }
    
    private func fetchCards() {
        services.dataCoordinator
            .fetchCards(forPlaylists: selectedPlaylists.value)
            .subscribe(onNext: { [weak self] in self?.updateSectionWithCards($0) })
            .disposed(by: disposeBag)
    }
    
    private func fetchData() {
        services.dataCoordinator
            .getPlaylists(forLanguage: language.value, userId: user.uid)
            .execute { [weak self] (newPlaylists) in
                let sortedPlaylists = newPlaylists.sorted(by: {
                    $0.dateCreated.timeIntervalSince1970 > $1.dateCreated.timeIntervalSince1970  })
                self?.playlists.accept(sortedPlaylists) }
            .withLatestFrom(selectedPlaylists) { ($0, $1) }
            .map { [weak self] (newPlaylists, selectedPlaylists) -> [Playlist] in
                var newSelectedPlaylist = selectedPlaylists
                newSelectedPlaylist = newSelectedPlaylist.filter{ newPlaylists.map{$0.id}.contains($0.id) }
                if newSelectedPlaylist.count == 0, let firstPlaylist = newPlaylists.first {
                    newSelectedPlaylist.append(firstPlaylist)
                    self?.selectedPlaylists.accept(newSelectedPlaylist)
                }
                return newSelectedPlaylist }
            .withLatestFrom(Observable.just(services.dataCoordinator) ) { ($0, $1) }
            .flatMap { selectedPlaylists, service -> Observable<[TranslateCard]> in
                return service.fetchCards(forPlaylists: selectedPlaylists) }
            .execute({ [weak self] in self?.updateSectionWithCards($0)})
            .map { (_) in return false }
            .bind(to: isRefreshing)
            .disposed(by: disposeBag)
    }
    
    private func receivedUserChanges(newChange: UserChanges.RealTimeEvents) {
        switch newChange {
        case .changedCardsList(let inLanguage, let playlistId):
            let isActualPlaylist = selectedPlaylists.value.map{ $0.id}.contains(playlistId)
            guard inLanguage == language.value, isActualPlaylist  else {
                return
            }
            fetchData()
        case .changedPlaylistsList(let ofLanguage):
            guard ofLanguage == language.value else { return }
            fetchData()
        case .nothing, .changedLanguageLists, .changedUser:
            break
        }
    }
}
