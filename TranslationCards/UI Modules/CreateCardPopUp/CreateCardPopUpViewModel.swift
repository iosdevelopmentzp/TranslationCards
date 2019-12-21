//
//  CreateCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

fileprivate enum CreateCardMode {
    case create
    case edit
}

final class CreateCardPopUpViewModel: ViewModel<CreateCardPopUpRouter> {
    
    enum EditFinishStatus {
        case changedPrases
        case removed
        case noChanges
    }
    
    var isRemoveButtonHidden: BehaviorRelay<Bool>
    
    fileprivate let mode: BehaviorRelay<CreateCardMode>
    fileprivate let user: User
    
    // Edit mode
    fileprivate var card: TranslateCard?
    fileprivate var cardEditFinishStatus: BehaviorRelay<EditFinishStatus>
    
    // Create new card mode
    fileprivate lazy var userPlaylists: BehaviorRelay<[Playlist]> = .init(value: [])
    fileprivate lazy var selectedPlaylist: BehaviorRelay<Playlist?> = .init(value: nil)
    fileprivate var callBackTargetLanguage: BehaviorRelay<Language?> = .init(value: nil)
    fileprivate var language: BehaviorRelay<LanguageBind>
    fileprivate lazy var sourceLanguage = BehaviorRelay<Language>.init(value: language.value.sourceLanguage)
    fileprivate lazy var targetLanguage = BehaviorRelay<Language>.init(value: language.value.targetLanguage)
    
    init(withCard card: TranslateCard, user: User, cardEditFinishStatus: (BehaviorRelay<EditFinishStatus>)? = nil) {
        mode = .init(value: .edit)
        self.user = user
        self.language = .init(value: card.language)
        self.card = card
        self.isRemoveButtonHidden = .init(value: false)
        if let cardEditFinishStatus = cardEditFinishStatus {
            self.cardEditFinishStatus = cardEditFinishStatus
        } else { self.cardEditFinishStatus = .init(value: .noChanges)}
        super.init()
    }
    
    init(user: User, language: LanguageBind) {
        mode = .init(value: .create)
        self.user = user
        self.language = .init(value: language)
        self.isRemoveButtonHidden = .init(value: true)
        self.cardEditFinishStatus = .init(value: .noChanges)
        super.init()
        
        self.language
            .subscribe(onNext: { [weak self] (language) in
                self?.user
                    .fetchPlaylists(forLanguage: language)
                    .subscribe(onError: { (error) in
                        debugPrint("Failed fetch user playlists")
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
        
        user.playlists
            .map { $0?.filter{ [weak self] in
                guard let self = self else { return false}
                return $0.key == self.language.value
            }.first }
            .compactMap { $0?.value}
            .subscribe(onNext: { [weak self] (playlist) in
                self?.userPlaylists.accept(playlist)
            })
            .disposed(by: disposeBag)
        
        callBackTargetLanguage
            .compactMap{ $0 }
            .subscribe(onNext: { [weak self] (language) in
                guard let self = self else { return }
                self.targetLanguage.accept(language)
                let newLangBind = LanguageBind(source: self.sourceLanguage.value, target: self.targetLanguage.value)
                self.language.accept(newLangBind)
            })
            .disposed(by: disposeBag)
    }
    
    func bind(withNewPhrase newPhrase: ControlProperty<String>,
              translation: ControlProperty<String>,
              saveButtonPressed: ControlEvent<Void>,
              cancelButtonPressed: ControlEvent<Void>,
              removeButtonPressed: ControlEvent<Void>) {

        let inputData = Observable.combineLatest(newPhrase, translation)
        saveButtonPressed
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (sourcePhrase, targetPhrase) in
                guard !sourcePhrase.isEmpty, !targetPhrase.isEmpty else {
                    self?.alertModel.accept(.warningAlert(message: "Fill in all the fields", handler: nil))
                    return
                }
                
                guard let self = self else { return }
                
                guard self.mode.value == .create else {
                    if let card = self.card, card.sourcePhrase != sourcePhrase || card.targetPhrase != targetPhrase {
                        self.updateCard(sourcePhrase: sourcePhrase, targetPhrase: targetPhrase, forCard: card)
                    }
                    return
                }
                
                self.router.route(to: .selectPlaylistView(dataSource: self.userPlaylists.value, selectedAction: { [weak self] (playlist) in
                      self?.selectedPlaylist.accept(playlist)
                }, firstRowTitle: "Create new playlist",
                   createNewPlaylistCallBack: { [weak self] in
                    let model: TextFieldAlertModel = .createPlaylistModel(okAction: { [weak self] (newPlaylistName) in
                        guard !newPlaylistName.isEmpty else {
                            self?.alertModel.accept(.warningAlert(message: "Playlist name must not be empty", handler: nil))
                            return
                        }
                        let theSamePlaylists = self?.userPlaylists.value.filter{ $0.name == newPlaylistName}
                        guard let theSamePlaylistsNotOptional = theSamePlaylists, theSamePlaylistsNotOptional.count <= 0 else {
                            self?.alertModel.accept(.warningAlert(message: "Playlist with name \(newPlaylistName) already exists", handler: nil))
                            return
                        }
                        guard let self = self else { return }
                        let newPlaylist = Playlist(name: newPlaylistName, dateCreated: Date(), userOwnerId: self.user.uid, language: self.language.value)
                        
                        self.startActivityIndicator.accept(true)
                        self.user.addNewPlaylist(playlist: newPlaylist)
                            .subscribe(onNext: { [weak self](_) in
                                self?.startActivityIndicator.accept(false)
                                self?.selectedPlaylist.accept(newPlaylist)
                                }, onError: { [weak self] (error) in
                                    self?.startActivityIndicator.accept(false)
                                    self?.alertModel.accept(.warningAlert(message: "Failed create new playlist", handler: nil))
                            })
                            .disposed(by: self.disposeBag)
                    }, cancelAction: { } )
                    self?.textFieldAlertModel.accept(model)
                }))
            })
            .disposed(by: disposeBag)
        
        cancelButtonPressed
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
                self?.cardEditFinishStatus.accept(.noChanges)
            })
            .disposed(by: disposeBag)
        
        removeButtonPressed
            .withLatestFrom(mode)
            .filter { (mode) -> Bool in
                mode == .edit }
            .subscribe(onNext: { [weak self] (_) in
                guard let card = self?.card else {
                    debugPrint("Failed remove card. Card not created")
                    return
                }
                self?.removeCard(card)
            })
            .disposed(by: disposeBag)
        
        switch mode.value {
        case .edit:
            if let card = card {
                newPhrase.onNext(card.sourcePhrase)
                translation.onNext(card.targetPhrase)
            }
        case .create:
            selectedPlaylist
                .compactMap { $0 }
                .withLatestFrom(inputData)
                .subscribe(onNext: { [weak self] (sourcePhrase, targetPhrase) in
                    guard !sourcePhrase.isEmpty, !targetPhrase.isEmpty else {
                        self?.alertModel.accept(.warningAlert(message: "Fill in all the fields", handler: nil))
                        self?.selectedPlaylist.accept(nil)
                        return
                    }
                    
                    guard let self = self, let playlist = self.selectedPlaylist.value else { return }
                    let card = TranslateCard(userId: self.user.uid, language: self.language.value, sourcePhrase: sourcePhrase, targetPhrase: targetPhrase)
                    card.playlistId = playlist.id
                    self.saveTranslationCard(card: card)
                })
                .disposed(by: disposeBag)
        }
    }
    
    func bind(withSourceSelectLanguageButton sourceLanguageButton: ControlEvent<Void>,
                          targetSelectLanguageButton: ControlEvent<Void>) {
        
        targetSelectLanguageButton
            .withLatestFrom(mode)
            .filter{ $0 == .create }
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                let targetLanguages = Language.allCases.filter{ $0 != self.sourceLanguage.value}
                self.callBackTargetLanguage.accept(self.targetLanguage.value)
                self.router.route(to: .languagePickerView(currentLanguage: self.callBackTargetLanguage,
                                                          languageList: targetLanguages,
                                                          title: "Target language")) })
            .disposed(by: disposeBag)
    }
    
    func bind(sourceButtonImage: Binder<UIImage?>, targetButtonImage: Binder<UIImage?>) {
        sourceLanguage
            .map { $0.flagIcon }
            .bind(to: sourceButtonImage)
            .disposed(by: disposeBag)
        
        targetLanguage
            .map { $0.flagIcon }
            .bind(to: targetButtonImage)
            .disposed(by: disposeBag)
    }

    // MARK: - Private
    fileprivate func updateCard(sourcePhrase: String, targetPhrase: String, forCard card: TranslateCard) {
        guard sourcePhrase != card.sourcePhrase || targetPhrase != card.targetPhrase,
            !sourcePhrase.isEmpty, !targetPhrase.isEmpty else {
            return
        }
        card.update(sourcePhrase: sourcePhrase, targetPhrase: targetPhrase)
        
        self.startActivityIndicator.accept(true)
        User.user(withId: card.userOwnerId)
            .subscribe(onNext: { [weak self] (user) in
                user.saveCard(card)
                    .subscribe(onNext: { [weak self] (_) in
                        self?.router.dissmis()
                        self?.startActivityIndicator.accept(false)
                        self?.cardEditFinishStatus.accept(.changedPrases)
                        }, onError: { [weak self] (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.alertModel.accept(.warningAlert(message: "Failed update card. \(error.localizedDescription)", handler: nil))
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                }, onError: { [weak self] (error) in
                    self?.startActivityIndicator.accept(false)
                    self?.alertModel.accept(.warningAlert(message: "Failed get user with id \(card.userOwnerId) with error \(error)", handler: nil))
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func removeCard(_ card: TranslateCard) {
        self.startActivityIndicator.accept(true)
        
        User.user(withId: card.userOwnerId)
            .subscribe(onNext: { [weak self] (user) in
                user.removeCard(card)
                    .subscribe(onNext: { [weak self] (_) in
                        self?.router.dissmis()
                        self?.startActivityIndicator.accept(false)
                        self?.cardEditFinishStatus.accept(.removed)
                        }, onError: { [weak self] (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.alertModel.accept(.warningAlert(message: "Failed get remove card with error \(error.localizedDescription)", handler: nil))
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                }, onError: { [weak self] (error) in
                    self?.startActivityIndicator.accept(false)
                    self?.alertModel.accept(.warningAlert(message: "Failed get user with error \(error.localizedDescription)", handler: nil))
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func saveTranslationCard(card: TranslateCard) {
        
        self.startActivityIndicator.accept(true)
        
        User.user(withId: card.userOwnerId)
            .subscribe(onNext: { [weak self] (user) in
                user.saveCard(card)
                    .subscribe(onNext: { [weak self] (_) in
                        self?.router.dissmis()
                        self?.startActivityIndicator.accept(false)
                        }, onError: { (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.alertModel.accept(.warningAlert(message: "Failed save card with error \(error.localizedDescription)", handler: nil))
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                
            }, onError: { [weak self] (error) in
                self?.startActivityIndicator.accept(false)
                self?.alertModel.accept(.warningAlert(message: "Failed get user with error \(error.localizedDescription)", handler: nil))
                }
        )
        .disposed(by: disposeBag)
    }
}
