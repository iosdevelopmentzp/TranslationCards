//
//  CardSlideShowViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CardSlideShowViewModelInput {
    var copyCardToButtonTap: PublishSubject<Void> { get }
    var moveCardToButtonTap: PublishSubject<Void> { get }
    var editCardButtonTap: PublishSubject<Void> { get }
    var speechData: BehaviorRelay<SpeechData?> { get }
    var getCurrentCentralCellIndexPath: (() -> IndexPath?)? { set get }
    func stopTextPlayback()
}

protocol CardSlideShowViewModelOutput {
    var cards: BehaviorRelay<[TranslateCard]> { get }
    var isReverseMode: BehaviorRelay<Bool> { get }
}

protocol CardSlideShowViewModelType {
    var input: CardSlideShowViewModelInput { get }
    var output: CardSlideShowViewModelOutput { get }
}

extension CardSlideShowViewModelType where Self:  CardSlideShowViewModelInput & CardSlideShowViewModelOutput {
    var input: CardSlideShowViewModelInput { self }
    var output: CardSlideShowViewModelOutput { self }
}

final class CardSlideShowViewModel: ViewModel<CardSlideShowRouter>, CardSlideShowViewModelInput, CardSlideShowViewModelOutput, CardSlideShowViewModelType {
    
    let copyCardToButtonTap = PublishSubject<Void>()
    let moveCardToButtonTap = PublishSubject<Void>()
    let editCardButtonTap = PublishSubject<Void>()
    var getCurrentCentralCellIndexPath: (() -> IndexPath?)? = nil
    let speechData = BehaviorRelay<SpeechData?>.init(value: nil)
    
    let cards = BehaviorRelay<[TranslateCard]>.init(value: [])
    let isReverseMode: BehaviorRelay<Bool>
    
    // MARK: - Private combine observables
    private var currentCardAndUser: Observable<(user: User, currentCard: TranslateCard)> {
        Observable
            .just(getCurrentCentralCellIndexPath?())
            .unwrap()
            .withLatestFrom(cards) { ($1, $0) }
            .map { cards, indexPath in return cards[indexPath.row] }
            .flatMap{
                User.user(withId: $0.userOwnerId)
                    .withLatestFrom(Observable.just($0)) { ($0, $1) }
            }
    }
   
    init(cards: [TranslateCard], withReverse reverse: Bool = false) {
        self.cards.accept(cards)
        isReverseMode = .init(value: reverse)
        super.init()
        
        speechData
            .unwrap()
            .subscribe(onNext: { [weak self]  (speechData) in
                self?.services.speechService.speakText(withSpeechData: speechData)
            })
            .disposed(by: disposeBag)
        
        editCardButtonTap
            .subscribe(onNext: { [weak self] (_) in
                self?.openEditCardController()
            })
            .disposed(by: disposeBag)
        
        moveCardToButtonTap
            .subscribe(onNext: { [weak self] (_) in
                self?.openChoosingPlaylistForMoveCardToAnotherPlaylist()
            })
            .disposed(by: disposeBag)
        
        copyCardToButtonTap
            .subscribe(onNext: { [weak self] (_) in
                self?.openChoosingPlaylistForCopyCardToAnotherPlaylist()
            })
            .disposed(by: disposeBag)
    }
    // MARK: - Public
    func stopTextPlayback() {
        services.speechService.stopSpeaking()
    }
    
    // MARK: - Private
    private func openEditCardController() {
        currentCardAndUser
            .subscribe(onNext: { [weak self] (user, selectedCard) in
                self?.router.route(to: .editCard(selectedCard, user: user))
                }, onError: { [weak self] error in
                    self?.errorHandler(description: "Failed open edit card screen.", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func openChoosingPlaylistForCopyCardToAnotherPlaylist() {
        currentCardAndUser
            .flatMap { user, currentCard -> Observable<(User, [Playlist], TranslateCard)> in
                return user
                    .getPlaylists(forLanguage: currentCard.language)
                    .withLatestFrom(Observable.just((user: user, card: currentCard))){ ($1.user, $0, $1.card) } }
        .filter{ user, playlists, card in playlists.count > 1 }
        .subscribe(onNext: { [weak self] (user, playlistsDatSource, card) in
            let selectedPlaylist = playlistsDatSource.filter{ $0.id == card.playlistId}.first
            guard let selected = selectedPlaylist else { return }
            self?.openChoosingPlaylist(playlists: playlistsDatSource,
                                       selected: selected, completion: { [weak self] (selectedPlaylist) in
                    self?.copyCard(card, user: user, toPlaylist: selectedPlaylist)
            })
        }, onError: { [weak self] error in
            self?.errorHandler(description: "Failed move card.", error: error, withAlert: true)
        })
            .disposed(by: disposeBag)
    }
    
    private func openChoosingPlaylistForMoveCardToAnotherPlaylist() {
        currentCardAndUser
            .flatMap { user, currentCard -> Observable<(User, [Playlist], TranslateCard)> in
                return user
                    .getPlaylists(forLanguage: currentCard.language)
                    .withLatestFrom(Observable.just((user: user, card: currentCard))){ ($1.user, $0, $1.card) } }
        .filter{ user, playlists, card in playlists.count > 1 }
        .subscribe(onNext: { [weak self] (user, playlistsDatSource, card) in
            let selectedPlaylist = playlistsDatSource.filter{ $0.id == card.playlistId}.first
            guard let selected = selectedPlaylist else { return }
            self?.openChoosingPlaylist(playlists: playlistsDatSource, selected: selected, completion: { [weak self] (selectedPlaylist) in
                    self?.moveCard(card, user: user, toPlaylist: selectedPlaylist)
            })
        }, onError: { [weak self] error in
            self?.errorHandler(description: "Failed move card.", error: error, withAlert: true)
        })
            .disposed(by: disposeBag)
    }
    
    private func openChoosingPlaylist(playlists: [Playlist], selected: Playlist, completion: @escaping ((Playlist) -> Void)) {
        let callBack: PlaylistCallBack = { (selectedPlaylist) in
            guard selectedPlaylist != selected else { return }
            completion(selectedPlaylist)
        }
        router.route(to: .choosingPlaylist(dataSource: playlists,
                                           selected: selected,
                                           callback: callBack))
    }
    
    private func copyCard(_ card: TranslateCard, user: User, toPlaylist playlist: Playlist) {
        user.copyCardToAnotherPlaylist(card: card, newPlaylistId: playlist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed copy card", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func moveCard(_ card: TranslateCard, user: User, toPlaylist playlist: Playlist) {
        user.moveCardToAnotherPlaylist(card: card, newPlaylistId: playlist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed move card", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
}
