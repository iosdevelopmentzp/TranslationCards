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
        guard let currentIndexPath = getCurrentCentralCellIndexPath?() else { return }
        let card = cards.value[currentIndexPath.row]
        services.credentials
            .getUser(withId: card.userOwnerId)
            .withLatestFrom(Observable.just(card)) { ($0, $1) }
            .catchError({ [weak self] (error) -> Observable<(User, TranslateCard)> in
                self?.errorHandler(description: "Failed open edit card screen.", error: error, withAlert: true)
                return .error(error)
            })
            .subscribe(onNext: { [weak self] user, card  in
                self?.router.route(to: .editCard(card, user: user))
            })
            .disposed(by: disposeBag)
    }
    
    private func openChoosingPlaylistForCopyCardToAnotherPlaylist() {
        guard let currentIndexPath = getCurrentCentralCellIndexPath?() else { return }
        let card = cards.value[currentIndexPath.row]
        let currentPlaylistId = card.playlistId.value
        services
            .dataCoordinator
            .getPlaylists(forLanguage: card.language.value, userId: card.userOwnerId)
            .catchError({ [weak self] (error) -> Observable<[Playlist]> in
                self?.errorHandler(description: "Failed move card.", error: error, withAlert: true)
                return .error(error)
            })
            .filter{ $0.count > 0}
            .compactMap { (playlists) -> ([Playlist], Playlist)? in
                let playlistsWithCardId = playlists.filter{ $0.id == currentPlaylistId}
                guard let selectedPlaylist = playlistsWithCardId.first else { return nil }
                return (playlists, selectedPlaylist) }
            .subscribe(onNext: { [weak self] (allPlaylist, selectedPlaylist) in
                let callBack: PlaylistCallBack = { [weak self] (playlist) in
                    self?.copyCard(card, toPlaylist: playlist)
                }
                self?.router.route(to: .choosingPlaylist(dataSource: allPlaylist, selected: selectedPlaylist, callback: callBack))
            })
            .disposed(by: disposeBag)
    }
    
    private func openChoosingPlaylistForMoveCardToAnotherPlaylist() {
        guard let currentIndexPath = getCurrentCentralCellIndexPath?() else { return }
        let card = cards.value[currentIndexPath.row]
        let currentPlaylistId = card.playlistId.value
        services
            .dataCoordinator
            .getPlaylists(forLanguage: card.language.value, userId: card.userOwnerId)
            .catchError({ [weak self] (error) -> Observable<[Playlist]> in
                self?.errorHandler(description: "Failed move card.", error: error, withAlert: true)
                return .error(error)
            })
            .filter{ $0.count > 0}
            .compactMap { (playlists) -> ([Playlist], Playlist)? in
                let playlistsWithCardId = playlists.filter{ $0.id == currentPlaylistId}
                guard let selectedPlaylist = playlistsWithCardId.first else { return nil }
                return (playlists, selectedPlaylist) }
            .subscribe(onNext: { [weak self] (allPlaylist, selectedPlaylist) in
                let callBack: PlaylistCallBack = { [weak self] (playlist) in
                    self?.moveCard(card, toPlaylist: playlist)
                }
                self?.router.route(to: .choosingPlaylist(dataSource: allPlaylist, selected: selectedPlaylist, callback: callBack))
            })
            .disposed(by: disposeBag)
    }
    
    private func copyCard(_ card: TranslateCard, toPlaylist playlist: Playlist) {
        services.dataCoordinator
            .copyCard(card, toNewPlaylistId: playlist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed copy card", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func moveCard(_ card: TranslateCard, toPlaylist playlist: Playlist) {
        services.dataCoordinator
            .moveCard(card, toNewPlaylistId: playlist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed move card", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
}
