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
    var isInputValid: BehaviorRelay<Bool> { get }
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
    let isInputValid = BehaviorRelay.init(value: false)
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
            .bind(to: isInputValid)
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
            .filter{ [weak self] (_) in self?.isInputValid.value ?? false }
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
                self?.router.dissmis()
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
            .bind(to: isInputValid)
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
                self?.router.dissmis()
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
            .withLatestFrom(inputPhrases)
            .filter{ !$0.sourcePharse.isEmpty }
            .withLatestFrom(card)
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
            .execute({ [weak self] (_) in
                self?.startActivityIndicator.accept(false)
            })
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
                }, onError: { [weak self] (error) in
                    self?.errorHandler(description: "Failed attempt to save card", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func removeTranslationCard(_ card: TranslateCard, forUser user: User) {
        startActivityIndicator.accept(true)
        user.removeCard(card)
            .execute { [weak self] (_) in
                self?.startActivityIndicator.accept(false) }
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
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
    
    /*
    
    var targetPhraseReverse: BehaviorRelay<String?> = .init(value: nil)
    
  +  fileprivate let mode: BehaviorRelay<CreateCardMode>
   + fileprivate let user: User
    
    // Edit mode
    fileprivate var card: TranslateCard?
    
    // Create new card mode
    fileprivate lazy var userPlaylists: BehaviorRelay<[Playlist]> = .init(value: [])
    fileprivate lazy var selectedPlaylist: BehaviorRelay<Playlist?> = .init(value: nil)
    fileprivate var callBackTargetLanguage: BehaviorRelay<Language?> = .init(value: nil)
     fileprivate var language: BehaviorRelay<LanguageBind>
     fileprivate lazy var sourceLanguage = BehaviorRelay<Language>.init(value: language.value.sourceLanguage)
     fileprivate lazy var targetLanguage = BehaviorRelay<Language>.init(value: language.value.targetLanguage)

    
    func bind(withNewPhrase newPhrase: ControlProperty<String>,
              translation: ControlProperty<String>,
              saveButtonPressed: ControlEvent<Void>,
              cancelButtonPressed: ControlEvent<Void>,
              removeButtonPressed: ControlEvent<Void>) {

        
        let inputData = Observable.combineLatest(newPhrase, translation)
        
        // Validate
        inputData
            .skip(1)
            .map { [weak self] (sourcePrase, targetPhrase) -> Bool in
                guard let self = self else { return false }
                guard !sourcePrase.isEmpty && !targetPhrase.isEmpty else { return false }
                switch self.mode.value {
                case .create: return true
                case .edit:
                    if let card = self.card {
                        return (card.sourcePhrase != sourcePrase) || (card.targetPhrase != targetPhrase)
                    }
                }
                return false }
            .bind(to: isInputValide)
            .disposed(by: disposeBag)
        
        // SAVE pressed
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
                                    self?.errorHandler(description: "Failed create new playlist", error: error, withAlert: true)
                            })
                            .disposed(by: self.disposeBag)
                    }, cancelAction: { } )
                    self?.textFieldAlertModel.accept(model)
                }))
            })
            .disposed(by: disposeBag)
        
        // CANCEL pressed
        cancelButtonPressed
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
            })
            .disposed(by: disposeBag)
        
        // REMOVE button pressef (only in edit mode)
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
        
        // configure dependens of self.mode
        switch mode.value {
        case .edit:
            if let card = card {
                newPhrase.onNext(card.sourcePhrase)
                translation.onNext(card.targetPhrase)
            }
        case .create:
            selectedPlaylist
                .unwrap()
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
    
    func bind(translateInRealTimeButtonEvent translateEvent: ControlEvent<Void>, sourcePhraseProperty: ControlProperty<String?>, targetPhraseProperty: ControlProperty<String?>) {
        
        (targetPhraseProperty <-> targetPhraseReverse).disposed(by: disposeBag)

        callBackTargetLanguage.subscribe(onNext: { (language) in
            debugPrint(language?.description ?? "")
            }).disposed(by: disposeBag)

        targetLanguage
            .skip(1)
            .subscribe(onNext: { [weak self] (language) in
                self?.targetPhraseReverse.accept("")
            })
            .disposed(by: disposeBag)

        let inputData = Observable.combineLatest(sourcePhraseProperty, targetPhraseProperty)
        translateEvent
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (sourcePhrase, targetPhrase) in
                guard let sourcePhrase = sourcePhrase, !sourcePhrase.isEmpty, let self = self else { return }
                self.services
                    .translateService
                    .translateText(sourcePhrase,fromLanguage: self.sourceLanguage.value, toLanguage: self.targetLanguage.value)
                    .subscribe(onNext: { [weak self] (translate) in
                        self?.targetPhraseReverse.accept(translate)
                    }, onError: { [weak self] error in
                        self?.errorHandler(description: "Failed translate phrase with real time service.", error: error, withAlert: true)
                    })
                    .disposed(by: self.disposeBag)
            })
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
                        }, onError: { [weak self] (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.errorHandler(description: "Failed update card.", error: error, withAlert: true)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                }, onError: { [weak self] (error) in
                    self?.startActivityIndicator.accept(false)
                    self?.errorHandler(description: "Failed get user with id \(card.userOwnerId)", error: error, withAlert: true)
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
                        }, onError: { [weak self] (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.errorHandler(description: "Failed get remove card.", error: error, withAlert: true)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                }, onError: { [weak self] (error) in
                    self?.startActivityIndicator.accept(false)
                    self?.errorHandler(description: "Failed get user.", error: error, withAlert: true)
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
                            self?.errorHandler(description: "Failed save card", error: error, withAlert: true)
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                
            }, onError: { [weak self] (error) in
                self?.startActivityIndicator.accept(false)
                self?.errorHandler(description: "Failed get user", error: error, withAlert: true)
                }
        )
        .disposed(by: disposeBag)
    }
 */
}
