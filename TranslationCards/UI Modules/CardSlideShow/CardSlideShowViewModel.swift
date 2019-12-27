//
//  CardSlideShowViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class CardSlideShowViewModel: ViewModel<CardSlideShowRouter> {
    var cards = BehaviorRelay<[TranslateCard]>.init(value: [])
    let cellSpeechData = BehaviorRelay<SpeechData?>.init(value: nil)
    var getSelectedCellIndexPath: (() -> IndexPath?)? = nil
    
    init(cards: [TranslateCard]) {
        let isShuffle = arc4random() % 2 == 0 ? true : false
        if isShuffle {
            let shuffleArray = cards.shuffled()
            self.cards.accept(shuffleArray)
        } else {
            self.cards.accept(cards)
        }
        super.init()
        binding()
    }
    
    func viewDisappeared() {
        services.speechService.stopSpeaking()
    }
    
    func bindWIthActionButtons(editCardEvent: ControlEvent<Void>, moveCardToEvent: ControlEvent<Void>) {
        editCardEvent
            .subscribe(onNext: { [weak self] (_) in
                self?.openEditCardController()
            })
            .disposed(by: disposeBag)
        
        moveCardToEvent
            .subscribe(onNext: { [weak self] (_) in
                self?.openMoveCardToController()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func openMoveCardToController() {
        guard let indexPath = getSelectedCellIndexPath?() else { return }
        let card = cards.value[indexPath.row]
        
        User.user(withId: card.userOwnerId).subscribe(onNext: { [weak self] (user) in
            user.getPlaylists(forLanguage: card.language)
                .subscribe(onNext: { [weak self] (playlists) in
                    let selectedPlaylist = playlists.filter{ $0.id == card.playlistId}.first
                    guard let selected = selectedPlaylist else { return }
                    self?.router.route(to: .moveCardTo(dataSource: playlists, selected: selected, callback: { (selectedPlaylist) in
                        guard selectedPlaylist != selected else { return }
                        user.moveCardToAnotherPlaylist(card: card, newPlaylistId: selectedPlaylist.id)
                            .subscribe(onError: { (error) in
                                self?.errorHandler(description: "Failed move card", error: error, withAlert: true)
                            })
                            .disposed(by: self?.disposeBag ?? DisposeBag())
                    }))
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
        })
        .disposed(by: disposeBag)
    }
    
    fileprivate func openEditCardController() {
        guard let indexPath = getSelectedCellIndexPath?() else { return }
        let card = cards.value[indexPath.row]
        User.user(withId: card.userOwnerId)
            .subscribe(onNext: { [weak self] (user) in
                self?.router.route(to: .editCard(card, user: user))
            })
        .disposed(by: disposeBag)
    }
    
    fileprivate func binding() {
        cellSpeechData
            .compactMap{$0}
            .subscribe(onNext: { [weak self]  (speechData) in
                self?.services.speechService.speakText(speechData)
            })
            .disposed(by: disposeBag)
    }
    
}
