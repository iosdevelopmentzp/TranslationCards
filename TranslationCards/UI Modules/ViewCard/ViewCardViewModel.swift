//
//  ViewCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class ViewCardViewModel: ViewModel<ViewCardRouter> {
    
    let user: User
    let card: BehaviorRelay<TranslateCard>
    lazy var title = BehaviorRelay<String>.init(value: card.value.sourcePhrase)
    
    init(card: TranslateCard, user: User) {
        self.card = .init(value: card)
        self.user = user
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
    }
    
    func stopSpeach() {
        services.speechService.stopSpeaking()
    }
    
    func bind(speakData: BehaviorRelay<SpeechData?>) {
        speakData
            .unwrap()
            .subscribe(onNext: { [weak self] (speakData) in
            self?.services.speechService.speakText(speakData)
        })
        .disposed(by: disposeBag)
    }
    
    func bind(editEvent: ControlEvent<Void>, moveCardToEvent: ControlEvent<Void>, copyCardToEvent: ControlEvent<Void>) {
        editEvent
            .subscribe(onNext: { [weak self] (_) in
                self?.stopSpeach()
                guard let self = self else { return }
                self.router.route(to: .editCard(card: self.card.value, user: self.user))
            })
            .disposed(by: disposeBag)
        
        moveCardToEvent
            .subscribe(onNext: { [weak self] (_) in
                self?.stopSpeach()
                guard let card = self?.card.value else { return }
                self?.openMoveCardToAnotherPlaylistView(card: card)
            })
            .disposed(by: disposeBag)
        
        copyCardToEvent
            .subscribe(onNext: { [weak self] (_) in
                self?.stopSpeach()
                guard let card = self?.card.value else { return }
                self?.openCopyCardToAnotherPlaylist(card: card)
            })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func openCopyCardToAnotherPlaylist(card: TranslateCard) {
        user.getPlaylists(forLanguage: card.language)
        .subscribe(onNext: { [weak self] (playlists) in
            let potentialCurrentPlaylist = playlists.first{ $0.id == card.playlistId}
            guard let currentPlaylist = potentialCurrentPlaylist else { return }
            let callBack: PlaylistCallBack = { [weak self] (playlist) in
                self?.needCopyCardToPlaylist(card: card, newPlaylist: playlist)
            }
            self?.router.route(to: .moveCardTo(dataSource: playlists, selected: currentPlaylist, callback: callBack))
        }, onError:  { [weak self] (error) in
            self?.errorHandler(description: "Failed get user playlists", error: error, withAlert: true)
        })
        .disposed(by: disposeBag)
    }
    
    private func openMoveCardToAnotherPlaylistView(card: TranslateCard) {
        user.getPlaylists(forLanguage: card.language)
            .subscribe(onNext: { [weak self] (playlists) in
                let potentialCurrentPlaylist = playlists.first{ $0.id == card.playlistId}
                guard let currentPlaylist = potentialCurrentPlaylist else { return }
                let callBack: PlaylistCallBack = { [weak self] (playlist) in
                    self?.needUpdateCardPlaylist(card: card, newPlaylist: playlist)
                }
                self?.router.route(to: .moveCardTo(dataSource: playlists, selected: currentPlaylist, callback: callBack))
            }, onError:  { [weak self] (error) in
                self?.errorHandler(description: "Failed get user playlists", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func needUpdateCardPlaylist(card: TranslateCard, newPlaylist: Playlist) {
        user.moveCardToAnotherPlaylist(card: card, newPlaylistId: newPlaylist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed update card playlist", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func needCopyCardToPlaylist(card: TranslateCard, newPlaylist: Playlist) {
        user.copyCardToAnotherPlaylist(card: card, newPlaylistId: newPlaylist.id)
            .subscribe(onError: { [weak self] (error) in
                self?.errorHandler(description: "Failed copy card playlist", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
}
