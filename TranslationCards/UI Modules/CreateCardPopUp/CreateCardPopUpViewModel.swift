//
//  CreateCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CreateCardPopUpViewModelInput {
    var sourcePhraseText: PublishSubject<String> { get }
    var targetPhraseText: PublishSubject<String> { get }
    var saveButtonTap: PublishSubject<Void> { get }
    var removeButtonTap: PublishSubject<Void> { get }
    var translateButtonTap: PublishSubject<Void> { get }
    var cancelButtonTap: PublishSubject<Void> { get }
    var targetLanguageTap: PublishSubject<Void> { get }
}

protocol CreateCardPopUpViewModelOutput {
    var card: BehaviorRelay<TranslateCard> { get }
    var mode: BehaviorRelay<CreateCardMode> { get }
    var isInputCorrect: BehaviorRelay<Bool> { get }
}

protocol CreateCardPopUpViewModelType {
    var input: CreateCardPopUpViewModelInput { get }
    var output: CreateCardPopUpViewModelOutput { get }
}

extension CreateCardPopUpViewModelType where Self: CreateCardPopUpViewModelInput & CreateCardPopUpViewModelOutput {
    var input: CreateCardPopUpViewModelInput { self }
    var output: CreateCardPopUpViewModelOutput { self }
}

enum CreateCardMode {
    case create
    case edit
}

final class CreateCardPopUpViewModel: ViewModel<CreateCardPopUpRouter>, CreateCardPopUpViewModelType, CreateCardPopUpViewModelOutput, CreateCardPopUpViewModelInput {
    
    let sourcePhraseText = PublishSubject<String>()
    let targetPhraseText = PublishSubject<String>()
    let saveButtonTap = PublishSubject<Void>()
    let removeButtonTap = PublishSubject<Void>()
    let translateButtonTap = PublishSubject<Void>()
    let cancelButtonTap = PublishSubject<Void>()
    var targetLanguageTap = PublishSubject<Void>()
    
    let card: BehaviorRelay<TranslateCard>
    let isInputCorrect = BehaviorRelay.init(value: false)
    let mode: BehaviorRelay<CreateCardMode>
    
    private let user: BehaviorRelay<User>
    private lazy var callBackTargetLanguage: BehaviorRelay<Language?> = .init(value: nil)
    private lazy var currentUserPlaylists: BehaviorRelay<[Playlist]?> = .init(value: nil)
    private lazy var selectedPlaylist: BehaviorRelay<Playlist?> = .init(value: nil)
    private lazy var newPlaylistName: BehaviorRelay<String?> = .init(value: nil)
    
    // combined private observables
    private var inputPhrases: Observable<(sourcePharse: String, targetPhrase: String)> {
        Observable.combineLatest(self.sourcePhraseText.asObservable(), self.targetPhraseText.asObservable()) {
            return (sourcePharse: $0, targetPhrase: $1)
        }
    }
    
    private lazy var newTargetLanguage: Observable<Language> = {
        self.callBackTargetLanguage
            .withLatestFrom(self.card){ ($0, $1) }
            .compactMap { newTargetLanguage, card -> Language? in
                guard let newLanguage = newTargetLanguage,
                    newTargetLanguage != card.language.targetLanguage else { return nil}
                return newTargetLanguage }
    }()

    // MARK: Init with create mode
    init(user: User, language: LanguageBind) {
        mode = .init(value: .create)
        self.user = .init(value: user)
        let cardTemplate = TranslateCard(userId: user.uid, language: language, sourcePhrase: "", targetPhrase: "")
        self.card = .init(value: cardTemplate)
        super.init()
        
        commonBinding()
        
        newTargetLanguage
            .withLatestFrom(self.card) { newTargetLanguage, card -> (LanguageBind, TranslateCard) in
                let newLanguage = LanguageBind(source: card.language.sourceLanguage, target: newTargetLanguage)
                return (newLanguage, card) }
            .subscribe(onNext: { [weak self] (newLanguage, card) in
                card.updateLanguage(newLanguage)
                self?.card.accept(card)
            })
            .disposed(by: disposeBag)
        
        inputPhrases
            .map { !$0.isEmpty && !$1.isEmpty }
            .distinctUntilChanged()
            .bind(to: isInputCorrect)
            .disposed(by: disposeBag)
        
        newPlaylistName
            .unwrap()
            .withLatestFrom(self.user) { ($0, $1) }
            .withLatestFrom(self.card) { ($0.0, $0.1, $1) }
            .subscribe(onNext: { [weak self] (newPlaylistName, user, card) in
                self?.createNewPlaylist(forUser: user, card: card, withPlaylistName: newPlaylistName)
            })
            .disposed(by: disposeBag)
        
        selectedPlaylist
            .unwrap()
            .filter{ [weak self] (_) in self?.isInputCorrect.value ?? false }
            .withLatestFrom(Observable.combineLatest(self.card, self.user)) { ($0, $1.0, $1.1) }
            .subscribe(onNext: { [weak self] (playlist, card, user) in
                card.updatePlaylistID(playlist.id)
                self?.saveTranslationCard(card, forUser: user)
            })
            .disposed(by: disposeBag)
            
        saveButtonTap
            .withLatestFrom(self.card)
            .subscribe(onNext: { [weak self] (card) in
                self?.choicePlaylistAction(forCard: card)
            })
            .disposed(by: disposeBag)
        
        cancelButtonTap
            .subscribe(onNext: { [weak self] (_) in
                self?.router.comeBack()
            })
            .disposed(by: disposeBag)
        
        targetLanguageTap
            .withLatestFrom(mode)
            .filter{ $0 == .create}
            .withLatestFrom(card)
            .map{ (card) -> ([Language], Language) in
                let languages = Language.allCases.filter{ $0 != card.language.sourceLanguage}
                return (languages, card.language.targetLanguage) }
            .subscribe(onNext: { [weak self] languages, selectedLanguage in
                self?.selectTargetLanguage(fromLanguages: languages, selectedLanguage: selectedLanguage)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Init with edit mode
    init(withCard card: TranslateCard, user: User) {
        mode = .init(value: .edit)
        self.user = .init(value: user)
        self.card = .init(value: card)
        super.init()
        
        commonBinding()
        
        let initialSourceText = card.sourcePhrase
        let initialTargetText = card.targetPhrase
        inputPhrases
            .map {
                !$0.isEmpty && !$1.isEmpty && ($0 != initialSourceText || $1 != initialTargetText) }
            .distinctUntilChanged()
            .bind(to: isInputCorrect)
            .disposed(by: disposeBag)
        
        saveButtonTap
            .withLatestFrom( Observable.combineLatest(self.card, self.user) )
            .subscribe(onNext: { [weak self] (card, user) in
                self?.saveTranslationCard(card, forUser: user)
            })
            .disposed(by: disposeBag)
        
        removeButtonTap
            .withLatestFrom(Observable.combineLatest(self.card, self.user))
            .subscribe(onNext: { [weak self] card, user in
                self?.removeTranslationCard(card, forUser: user)
            })
            .disposed(by: disposeBag)
        
        cancelButtonTap
            .withLatestFrom(self.card)
            .subscribe(onNext: { [weak self] (_) in
                card.update(sourcePhrase: initialSourceText, targetPhrase: initialTargetText)
                self?.router.comeBack()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func commonBinding() {
        inputPhrases
            .withLatestFrom(card) { ($0.sourcePharse, $0.targetPhrase, $1)}
            .subscribe(onNext: { (sourcePhrase, targetPhrase, card) in
                card.update(sourcePhrase: sourcePhrase, targetPhrase: targetPhrase)
            })
            .disposed(by: disposeBag)
        
        translateButtonTap
            .withLatestFrom(self.card)
            .filter{ !$0.sourcePhrase.isEmpty }
            .subscribe(onNext: { [weak self] card in
                self?.translateSourceText(forCard: card)
            })
            .disposed(by: disposeBag)
    }
    
    private func selectTargetLanguage(fromLanguages languages: [Language], selectedLanguage: Language) {
        callBackTargetLanguage.accept(selectedLanguage)
        router.route(to: .languagePickerView(currentLanguage: callBackTargetLanguage,
                                                  languageList: languages,
                                                  title: "Select target language"))
    }
    
    private func choicePlaylistAction(forCard card: TranslateCard) {
        let createNewPlaylistCallBack: EmptyCallBack = { [weak self] in self?.attemptGetNewPlaylistName() }
        let selectedAction: PlaylistCallBack = {
            [weak self] selectedPlaylist in
            self?.selectedPlaylist.accept(selectedPlaylist)
        }
        user.value.getPlaylists(forLanguage: card.language)
            .subscribe(onNext: { [weak self] (playlists) in
                self?.currentUserPlaylists.accept(playlists)
                let route = CreateCardPopUpRouter.Route.selectPlaylistView(dataSource: playlists, selectedAction: selectedAction, firstRowTitle: "Create new playlist", createNewPlaylistCallBack: createNewPlaylistCallBack)
                self?.router.route(to: route)
                }, onError: { [weak self] (error) in
                    self?.errorHandler(description: "Failed attempt to get playlists list", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func attemptGetNewPlaylistName() {
        guard let currentUserPlaylists = currentUserPlaylists.value else { return }
        let okAction: (String)->() = { [weak self] newPlaylistName in
            guard !newPlaylistName.isEmpty else {
                self?.alertModel.accept(.warningAlert(message: "Playlist name must not be empty", handler: nil))
                return
            }
            let theSamePlaylists = currentUserPlaylists.filter{ $0.name == newPlaylistName}
            guard theSamePlaylists.count == 0 else {
                self?.alertModel.accept(.warningAlert(message: "Playlist with name \(newPlaylistName) already exists", handler: nil))
                return
            }
            self?.newPlaylistName.accept(newPlaylistName)
        }
        let model: TextFieldAlertModel = .createPlaylistModel(okAction: okAction, cancelAction: {})
        textFieldAlertModel.accept(model)
    }
    
    private func createNewPlaylist(forUser user: User, card: TranslateCard, withPlaylistName playlistName: String) {
        let playlist = Playlist(name: playlistName, dateCreated: Date(), userOwnerId: user.uid, language: card.language)
        user.addNewPlaylist(playlist: playlist)
            .subscribe(onNext: { [weak self] (_) in
                self?.selectedPlaylist.accept(playlist)
                }, onError: { [weak self] (error) in
                    self?.errorHandler(description: "Failed create new playlist with name \(playlistName)", error: error, withAlert: true) })
            .disposed(by: disposeBag)
    }
    
    private func saveTranslationCard(_ card: TranslateCard, forUser user: User) {
        self.startActivityIndicator.accept(true)
        user.saveCard(card)
            .subscribe(onNext: { [weak self] (_) in
                self?.router.comeBack()
                self?.startActivityIndicator.accept(false)
                }, onError: { [weak self] (error) in
                    self?.errorHandler(description: "Failed attempt to save card", error: error, withAlert: true)
                    self?.startActivityIndicator.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    private func removeTranslationCard(_ card: TranslateCard, forUser user: User) {
        startActivityIndicator.accept(true)
        user.removeCard(card)
            .execute { [weak self] (_) in
                self?.startActivityIndicator.accept(false) }
            .subscribe(onNext: { [weak self] (_) in
                self?.router.comeBack()
                }, onError: { [weak self] (error) in
                    self?.errorHandler(description: "Failed attempt to remove card", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func translateSourceText(forCard card: TranslateCard) {
        services
            .translateService
            .translateText(card.sourcePhrase, fromLanguage: card.language.sourceLanguage, toLanguage: card.language.targetLanguage)
            .unwrap()
            .map{ [weak card] (translatedText) -> TranslateCard? in
                card?.update(targetPhrase: translatedText)
                return card }
            .unwrap()
            .subscribe(onNext: { [weak self] (card) in
                self?.updateCard(withCard: card)
                }, onError: { [weak self] (error) in
                    self?.errorHandler(description: "Failed attempt to translate card", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateCard(withCard card: TranslateCard) {
        self.card.accept(card)
    }
}
