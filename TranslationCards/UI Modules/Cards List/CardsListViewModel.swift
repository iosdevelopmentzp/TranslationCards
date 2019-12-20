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
    var cardsDataSource = BehaviorRelay<[TranslateCard]>.init(value: [])
    var playlists: BehaviorRelay<[Playlist]> = .init(value: [])
    var selectedPlaylist: BehaviorRelay<[Playlist]> = .init(value: [])
    var didSelectedItemEvent: BehaviorRelay<IndexPath?> = .init(value: nil)
    
    lazy var titleText: BehaviorRelay<String?> = .init(value: nil)
    
    fileprivate let language: LanguageBind
    fileprivate let user: User
    
    init(language: LanguageBind, user: User) {
        self.language = language
        self.user = user
        super.init()
        
        self.titleText.accept("\(language.sourceLanguage) to \(language.targetLanguage)")
        
        didSelectedItemEvent
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let indexPath = indexPath, let cards =  self?.cardsDataSource.value,
                    indexPath.row < cards.count, indexPath.row >= 0 else { return }
                let card = cards[indexPath.row]
                guard let self = self else { return }
                self.router.route(to: .cardView(card: card, user: self.user))
            })
            .disposed(by: disposeBag)
        
        fetchPlaylists()
        
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
                self?.cardsDataSource.accept(cards)
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
    }
    
    func bindWith(startSlideShowButtonPressed startShowPressed: ControlEvent<Void>) {
        startShowPressed
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.router.route(to: .slideShow(cards: self.cardsDataSource.value)) })
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
    
    // MARK: - Private
    fileprivate func fetchCardsForSelectedPlaylists(_ playlists: [Playlist]) {
        playlists.forEach { [weak self] in
            self?.user.fetchCards(forPlaylist: $0)
                .subscribe(onNext: { (_) in
                    debugPrint("succesfull load cards")
                }, onError: { [weak self] (error) in
                    debugPrint("unsuccesfull load cards")
                    self?.alertModel.accept(.warningAlert(message: "Unsuccesfull load cards with Error \(error)", handler: nil))
                })
                .disposed(by: disposeBag)
        }
    }
    
    fileprivate func fetchPlaylists() {
        self.user.fetchPlaylists(forLanguage: language)
            .subscribe(onNext: { [weak self] (_) in
                debugPrint("succesfull load playlist for user \(self?.user.uid ?? "Unknow ID"), language \(self?.language.description ?? "")")
                }, onError: { [weak self] (error) in
                    debugPrint("unsuccesfull load playlist for user \(self?.user.uid ?? "Unknow ID"), language \(self?.language.description ?? "")")
                    self?.alertModel.accept(.warningAlert(message: "Unsuccesfull load playlist with Error \(error)", handler: nil))
            })
            .disposed(by: disposeBag)
    }
}
