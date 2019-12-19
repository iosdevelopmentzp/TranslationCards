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

final class CardsListViewModel: ViewModel<CardsListRouter> {
    var cardsDataSource = BehaviorRelay<[TranslateCard]>.init(value: [])
    var playlists: BehaviorRelay<[Playlist]> = .init(value: [])
    var currentPlaylist: BehaviorRelay<Playlist?> = .init(value: nil)
    var selectedItem: BehaviorRelay<IndexPath?> = .init(value: nil)
    
    lazy var titleText: BehaviorRelay<String?> = .init(value: nil)
    
    fileprivate let language: LanguageBind
    fileprivate let user: User
    
    init(language: LanguageBind, user: User) {
        self.language = language
        self.user = user
        super.init()
        
        self.titleText.accept("\(language.sourceLanguage) to \(language.targetLanguage)")
        
        selectedItem
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let indexPath = indexPath, let cards =  self?.cardsDataSource.value,
                    indexPath.row < cards.count, indexPath.row >= 0 else { return }
                let card = cards[indexPath.row]
                self?.router.route(to: .cardView(card: card))
            })
            .disposed(by: disposeBag)
        
        fetchPlaylists()
        
        self.user
            .cardsList
            .subscribe(onNext: { [weak self] (cardsDictionary) in
                guard let currentPlaylist = self?.currentPlaylist.value else { return }
                let cards = cardsDictionary?.filter{ $0.key == currentPlaylist}.first?.value
                guard let newCards = cards else { return }
                self?.cardsDataSource.accept(newCards)
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
                self?.currentPlaylist.accept(newPlaylists.first)
            })
            .disposed(by: disposeBag)
        
        currentPlaylist
            .subscribe(onNext: { [weak self] (playlist) in
                guard let playlist = playlist else { return }
                self?.fetchCardsForPlaylists(playlist: playlist)
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
    
    // MARK: - Private
    fileprivate func fetchCardsForPlaylists(playlist: Playlist) {
        self.user.fetchCards(forPlaylist: playlist)
            .subscribe(onNext: { (_) in
                debugPrint("succesfull load cards")
                }, onError: { [weak self] (error) in
                    debugPrint("unsuccesfull load cards")
                    self?.alertModel.accept(.warningAlert(message: "Unsuccesfull load cards with Error \(error)", handler: nil))
            })
            .disposed(by: disposeBag)
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
