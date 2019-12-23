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
    }
    
    func stopSpeach() {
        services.speechService.stopSpeaking()
    }
    
    func bind(speakData: BehaviorRelay<SpeechData?>) {
        speakData
            .compactMap{ $0 }
            .subscribe(onNext: { [weak self] (speakData) in
            self?.services.speechService.speakText(speakData)
        })
        .disposed(by: disposeBag)
    }
    
    func bind(editEvent: ControlEvent<Void>, moveCardToEvent: ControlEvent<Void>) {
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
    }
    
    // MARK: - Private
    fileprivate func openMoveCardToAnotherPlaylistView(card: TranslateCard) {
        user.getPlaylists(forLanguage: card.language)
            .subscribe(onNext: { [weak self] (playlists) in
                let potentialCurrentPlaylist = playlists.first{ $0.id == card.playlistId}
                guard let currentPlaylist = potentialCurrentPlaylist else { return }
                let callBack: PlaylistCallBack = { [weak self] (playlist) in
                    self?.needUpdateCardPlaylist(card: card, newPlaylist: playlist)
                }
                self?.router.route(to: .moveCardTo(dataSource: playlists, selected: currentPlaylist, callback: callBack))
            }, onError:  { [weak self] (errro) in
                let description = "Failed get user playlists with error \(errro)"
                debugPrint(description)
                self?.alertModel.accept(.warningAlert(message: description, handler: nil))
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func needUpdateCardPlaylist(card: TranslateCard, newPlaylist: Playlist) {
        user.moveCardToAnotherPlaylist(card: card, newPlaylistId: newPlaylist.id)
            .subscribe(onError: { [weak self] (error) in
                let description = "Failed update card playlist with error \(error)"
                debugPrint(description)
                self?.alertModel.accept(.warningAlert(message: description, handler: nil))
            })
            .disposed(by: disposeBag)
    }
}
