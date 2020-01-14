//
//  ViewCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CardDetailsViewModelInput {
    var speechData: BehaviorRelay<SpeechData?> { get }
    var editCardTap: PublishSubject<Void> { get }
    var moveCardTap: PublishSubject<Void> { get }
    var copyCardTap: PublishSubject<Void> { get }
    func stopTextPlayback()
}

protocol CardDetailsViewModelOutput {
    var card: BehaviorRelay<TranslateCard> { get }
    var title: BehaviorRelay<String> { get }
}

protocol CardDetailsViewModelType {
    var input: CardDetailsViewModelInput { get }
    var output: CardDetailsViewModelOutput { get }
}

extension CardDetailsViewModelType where Self:  CardDetailsViewModelInput & CardDetailsViewModelOutput {
    var input: CardDetailsViewModelInput { self }
    var output: CardDetailsViewModelOutput { self }
}

final class CardDetailsViewModel: ViewModel<CardDetailsRouter>, CardDetailsViewModelInput, CardDetailsViewModelOutput, CardDetailsViewModelType {
    
    let speechData: BehaviorRelay<SpeechData?> = .init(value: nil)
    let editCardTap = PublishSubject<Void>()
    let moveCardTap = PublishSubject<Void>()
    let copyCardTap = PublishSubject<Void>()
    
    let card: BehaviorRelay<TranslateCard>
    var title: BehaviorRelay<String>
    
    fileprivate let user: BehaviorRelay<User>
    
    init(card: TranslateCard, user: User) {
        self.card = .init(value: card)
        self.user = .init(value: user)
        self.title = .init(value: card.sourcePhrase)
        super.init()
        
        card.runtimeEvents
            .skip(1)
            .withLatestFrom(self.card) { ($0, $1) }
            .subscribe(onNext: { [weak self] (event, card) in
                switch event {
                case .removed:
                    self?.router.comeBack()
                case .changed:
                    self?.card.accept(card)
                case .movedToAnotherPlaylist, .nothing:
                    break
                }})
            .disposed(by: disposeBag)
        
        speechData
            .unwrap()
            .subscribe(onNext: { [weak self] (speachData) in
                self?.services.speechService.speakText(withSpeechData: speachData)
            })
            .disposed(by: disposeBag)
        
        editCardTap
            .withLatestFrom(Observable.combineLatest(self.user, self.card))
            .subscribe(onNext: { [weak self] (user, card) in
                self?.router.route(to: .editCard(card: card, user: user))
            })
            .disposed(by: disposeBag)
        
        let playlistObservable: Observable<[Playlist]> = self.user.value.getPlaylists(forLanguage: self.card.value.language)
            
        copyCardTap
            .withLatestFrom(Observable.combineLatest(self.card, playlistObservable)) { ($1.0, $1.1) }
            .subscribe(onNext: { [weak self] (card, playlists) in
                self?.stopTextPlayback()
                self?.copyCardToAnotherPlaylistAction(withCard: card, playlists: playlists)
            })
            .disposed(by: disposeBag)
        
        moveCardTap
            .withLatestFrom(Observable.combineLatest(self.card, playlistObservable)) { ($1.0, $1.1) }
            .subscribe(onNext: { [weak self] (card, playlists) in
                self?.stopTextPlayback()
                self?.moveCardToAnotherPlaylistAction(withCard: card, playlists: playlists)
            })
            .disposed(by: disposeBag)
    }
    
    func stopTextPlayback() {
        services.speechService.stopSpeaking()
    }
    
    // MARK: - Private
    private func copyCardToAnotherPlaylistAction(withCard card: TranslateCard, playlists: [Playlist]) {
        let playlistsWithCardId = playlists.filter{ $0.id == card.playlistId}
        guard let selectedPlaylist = playlistsWithCardId.first else { return }
        let callBack: PlaylistCallBack = { [weak self] (playlist) in
            self?.needCopyCardToPlaylist(card: card, newPlaylist: playlist)
        }
        router.route(to: .choosingPlaylist(dataSource: playlists, selected: selectedPlaylist, callback: callBack))
    }
    
    private func moveCardToAnotherPlaylistAction(withCard card: TranslateCard, playlists: [Playlist]) {
        let playlistsWithCardId = playlists.filter{ $0.id == card.playlistId}
        guard let selectedPlaylist = playlistsWithCardId.first else { return }
        let callBack: PlaylistCallBack = { [weak self] (playlist) in
            self?.needMoveCardToPlaylist(card: card, newPlaylist: playlist)
        }
        router.route(to: .choosingPlaylist(dataSource: playlists, selected: selectedPlaylist, callback: callBack))
    }
    
    private func needMoveCardToPlaylist(card: TranslateCard, newPlaylist: Playlist) {
        user.value.moveCardToAnotherPlaylist(card: card, newPlaylistId: newPlaylist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed update card playlist", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func needCopyCardToPlaylist(card: TranslateCard, newPlaylist: Playlist) {
        user.value.copyCardToAnotherPlaylist(card: card, newPlaylistId: newPlaylist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed copy card playlist", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
}
