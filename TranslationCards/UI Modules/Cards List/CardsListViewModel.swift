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
import RSSelectionMenu

final class CardsListViewModel: ViewModel<CardsListRouter> {
    // output
    let sections: BehaviorRelay<[Section]> = BehaviorRelay(value: [])
    let isEditMode = BehaviorRelay.init(value: false)
    let reverseMode = BehaviorRelay.init(value: false)
    let shuffleMode = BehaviorRelay.init(value: false)
    let isFetchInProgress: BehaviorRelay<Bool> = .init(value: false)
    lazy var titleText: BehaviorRelay<String?> = .init(value: nil)
    
    // input
    let didSelectedItemEvent: BehaviorRelay<IndexPath?> = .init(value: nil)
    let fetchData: BehaviorRelay<Void> = .init(value: ())
    let deleteIndexPath: BehaviorRelay<IndexPath?> = .init(value: nil)

    fileprivate var playlists: BehaviorRelay<[Playlist]> = .init(value: [])
    fileprivate var selectedPlaylist: BehaviorRelay<[Playlist]> = .init(value: [])
    fileprivate let language: LanguageBind
    fileprivate let user: User
    
    init(language: LanguageBind, user: User) {
        self.language = language
        self.user = user
        super.init()
        
        // title of view
        self.titleText.accept("\(language.sourceLanguage) to \(language.targetLanguage)")
        
        // selected item event
        didSelectedItemEvent
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let indexPath = indexPath, let cards =  self?.sections.value.first?.mapToCards,
                    indexPath.row < cards.count, indexPath.row >= 0 else { return }
                let card = cards[indexPath.row]
                guard let self = self else { return }
                self.router.route(to: .cardView(card: card, user: self.user))
            })
            .disposed(by: disposeBag)
        
        // delete event
        deleteIndexPath
            .unwrap()
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let cards = self?.sections.value.first?.mapToCards else { return }
                let card = cards[indexPath.row]
                self?.startActivityIndicator.accept(true)
                self?.user
                    .removeCard(card)
                    .subscribe(onNext: { [weak self] (_) in
                        self?.startActivityIndicator.accept(false)
                        }, onError: { (error) in
                            self?.errorHandler(description: "Failed delete card", error: error, withAlert: true)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
        
        fetchData
            .subscribe(onNext: { [weak self] (_) in
                self?.isFetchInProgress.accept(true)
                self?.fetch()
                    .subscribe(onNext: { [weak self] (_) in
                        self?.isFetchInProgress.accept(false)
                    }, onError: { [weak self] (error) in
                        self?.isFetchInProgress.accept(false)
                        self?.errorHandler(description: "Failed fetch data", error: error, withAlert: true)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
        
        self.user
            .cardsList
            .subscribe(onNext: { [weak self] (cardsDictionary) in
                guard let currentPlaylist = self?.selectedPlaylist.value else { return }
                var cards: [TranslateCard] = []
                currentPlaylist.forEach { (playlist) in
                    let potentialCards = cardsDictionary?.filter{ $0.key == playlist}.first?.value
                    guard let newCards = potentialCards else { return }
                    cards += newCards
                }
                guard let self = self else { return }
                cards = self.sortCards(cards)
                self.updateSectionWithCards(cards)
            })
            .disposed(by: disposeBag)
        
        self.user
            .playlists
            .map { [weak self] playlists -> [Playlist]? in
                guard let language = self?.language else { return nil }
                return playlists?.filter{ $0.language == language } }
            .subscribe(onNext: { [weak self] (newPlaylists) in
                self?.playlists.accept(newPlaylists ?? [])
            })
            .disposed(by: disposeBag)
        
        playlists
            .subscribe(onNext: { [weak self] (newPlaylists) in
                guard let self = self else { return }
                var oldSelectedPlaylists = self.selectedPlaylist.value
                oldSelectedPlaylists = oldSelectedPlaylists.filter{ newPlaylists.contains($0) }
                if oldSelectedPlaylists.count <= 0, let randomPlaylist = newPlaylists.randomElement() {
                    oldSelectedPlaylists.append(randomPlaylist)
                }
                self.selectedPlaylist.accept(oldSelectedPlaylists)
            })
            .disposed(by: disposeBag)
        
        selectedPlaylist
            .subscribe(onNext: { [weak self] (playlists) in
                guard playlists.count > 0 else {
                    self?.sections.accept([Section(items: [])])
                    return
                }
                self?.fetchCardsForSelectedPlaylists(playlists)
            })
            .disposed(by: disposeBag)
        
        reverseMode.skip(1).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.reloadData() })
            .disposed(by: disposeBag)
        
        shuffleMode
            .skip(1)
            .subscribe(onNext: { [weak self] (shuffleMode) in
                guard let self = self else { return }
                let oldCars = self.sections.value.first?.mapToCards ?? []
                let newCards = shuffleMode ? oldCars.shuffled() : self.sortCards(oldCars)
                self.updateSectionWithCards(newCards)
            })
        .disposed(by: disposeBag)
    }
    
    func bindWith(startSlideShowButtonPressed startShowPressed: ControlEvent<Void>) {
        startShowPressed
            .withLatestFrom(sections)
            .compactMap{ $0.first?.mapToCards }
            .filter { $0.count > 0 }
            .subscribe(onNext: { [weak self] (sections) in
                let cards = sections
                self?.router.route(to: .slideShow(cards: cards, withReverse: self?.reverseMode.value ?? false))
            })
        .disposed(by: disposeBag)
    }
    
    func bindWith(playlistsSelectionEvent: ControlEvent<Void>) {
        playlistsSelectionEvent
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self, self.playlists.value.count > 1 else { return }
                self.router.route(to: .selectPlaylist(dataSource: self.playlists.value, selected: self.selectedPlaylist))
            })
            .disposed(by: disposeBag)
    }
    
    func bindWith(writePhraseSlideShowPressed: ControlEvent<Void>) {
        writePhraseSlideShowPressed
            .withLatestFrom(sections)
            .compactMap{ $0.first?.mapToCards }
            .filter{ $0.count > 0}
            .subscribe(onNext: { [weak self] (cards) in
                guard let self = self else { return }
                self.router.route(to: .writeSlideShow(cards: cards, withReverse: self.reverseMode.value)) })
            .disposed(by: disposeBag)
    }
    
    func bindWith(changeReverseState: ControlEvent<Void>, changeShuffleState: ControlEvent<Void>) {
        changeReverseState
            .withLatestFrom(reverseMode)
            .subscribe(onNext: { [weak self] (currentMode) in
                self?.reverseMode.accept(!currentMode) })
            .disposed(by: disposeBag)
        
        changeShuffleState
            .withLatestFrom(shuffleMode)
            .subscribe(onNext: { [weak self] (shuffleMode) in
                self?.shuffleMode.accept(!shuffleMode)
            })
            .disposed(by: disposeBag)
    }
    
    func bindWith(switchEditModePressed: ControlEvent<Void>) {
        switchEditModePressed
            .compactMap{ [weak self] (_) -> Bool in
                guard let self = self else { return false}
                return !self.isEditMode.value }
            .bind(to: isEditMode)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func reloadData() {
        sections.accept(sections.value)
    }
    
    fileprivate func updateSectionWithCards(_ cards: [TranslateCard]) {
        let items = cards.map{ Cell.init(item: $0)}
        sections.accept([Section(items: items)])
    }
    
    fileprivate func sortCards(_ cards: [TranslateCard]) -> [TranslateCard] {
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
    
    fileprivate func fetch() -> Observable<Void> {
        let playlistObservable = user.fetchPlaylists(forLanguage: language)
        let cardsObservable = user.fetchCards(forPlaylists: selectedPlaylist.value)
        return Observable.combineLatest(playlistObservable, cardsObservable).map{ _,_ in ()}
    }
    
    fileprivate func fetchCardsForSelectedPlaylists(_ playlists: [Playlist]) {
        playlists.forEach { [weak self] in
            self?.user.fetchCards(forPlaylist: $0)
                .subscribe(onError: { [weak self] (error) in
                    self?.errorHandler(description: "Unsuccesfull load cards", error: error, withAlert: true)
                })
                .disposed(by: disposeBag)
        }
    }
}
