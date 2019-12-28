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
    let cardsDataSource = BehaviorRelay<[TranslateCard]>.init(value: [])
    let didSelectedItemEvent: BehaviorRelay<IndexPath?> = .init(value: nil)
    lazy var titleText: BehaviorRelay<String?> = .init(value: nil)
    let fetchData: BehaviorRelay<Void> = .init(value: ())
    let isFetchInProgress: BehaviorRelay<Bool> = .init(value: false)
    let reverseMode = BehaviorRelay.init(value: false)
    let shuffleMode = BehaviorRelay.init(value: false)
    
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
                guard let indexPath = indexPath, let cards =  self?.cardsDataSource.value,
                    indexPath.row < cards.count, indexPath.row >= 0 else { return }
                let card = cards[indexPath.row]
                guard let self = self else { return }
                self.router.route(to: .cardView(card: card, user: self.user))
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
                self.cardsDataSource.accept(cards)
            })
            .disposed(by: disposeBag)
        
        self.user
            .playlists
            .subscribe(onNext: { [weak self] (playlisctsDictionary) in
                guard let playlisctsDictionary = playlisctsDictionary else { return }
                guard let language = self?.language else { return }
                let playlists = playlisctsDictionary.filter{ $0.key == language}.first?.value
                guard let newPlaylists = playlists else { return }
                self?.playlists.accept(newPlaylists)
                
                // set selectedPlaylist first playlist, if selectedPlaylist count == 0
                guard let firstPlaylist = playlists?.first,
                    let self = self,
                    self.selectedPlaylist.value.count == 0 else { return }
                self.selectedPlaylist.accept([firstPlaylist])
            })
            .disposed(by: disposeBag)
        
        selectedPlaylist
            .subscribe(onNext: { [weak self] (playlists) in
                guard playlists.count > 0 else {
                    self?.cardsDataSource.accept([])
                    return
                }
                self?.fetchCardsForSelectedPlaylists(playlists)
            })
            .disposed(by: disposeBag)
        
        reverseMode.skip(1).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.cardsDataSource.accept(self.cardsDataSource.value) })
            .disposed(by: disposeBag)
        
        shuffleMode
            .skip(1)
            .subscribe(onNext: { [weak self] (shuffleMode) in
                guard let self = self else { return }
                let cards = shuffleMode ? self.cardsDataSource.value.shuffled() : self.sortCards(self.cardsDataSource.value)
                self.cardsDataSource.accept(cards)
            })
        .disposed(by: disposeBag)
    }
    
    func bindWith(startSlideShowButtonPressed startShowPressed: ControlEvent<Void>) {
        startShowPressed
            .withLatestFrom(cardsDataSource)
            .filter { $0.count > 0 }
            .subscribe(onNext: { [weak self] (cards) in
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
            .withLatestFrom(cardsDataSource)
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
    
    // MARK: - Private
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
