//
//  CreateCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

enum CreateCardMode {
    case create
    case edit
}

final class CreateCardPopUpViewModel: ViewModel<CreateCardPopUpRouter> {
    
    var isRemoveButtonHidden: BehaviorRelay<Bool>
    let mode: BehaviorRelay<CreateCardMode>
    
    fileprivate let userId: String
    fileprivate var language: BehaviorRelay<LanguageBind>
    fileprivate lazy var sourceLanguage = BehaviorRelay<Language>.init(value: language.value.sourceLanguage)
    fileprivate lazy var targetLanguage = BehaviorRelay<Language>.init(value: language.value.targetLanguage)
    fileprivate var card: TranslateCard?
    
    fileprivate var callBackLanguage: BehaviorRelay<Language?> = .init(value: nil)
    
    init(withCard card: TranslateCard) {
        mode = .init(value: .edit)
        self.userId = card.id
        self.language = .init(value: card.language)
        self.card = card
        self.isRemoveButtonHidden = .init(value: false)
        super.init()
    }
    
    init(userId: String, language: LanguageBind) {
        mode = .init(value: .create)
        self.userId = userId
        self.language = .init(value: language)
        self.isRemoveButtonHidden = .init(value: true)
        super.init()
        
        sourceLanguage
            .filter({ [weak self] (sourceLanguage) -> Bool in
                guard let self = self else { return false }
                return self.language.value.sourceLanguage != sourceLanguage
            })
            .subscribe(onNext: { [weak self] (newSourceLanguage) in
                guard let self = self else { return }
                let oldSourceLanguage = self.language.value.sourceLanguage
                let oldTargetLanguage = self.language.value.targetLanguage
                let newTargetLanguage = newSourceLanguage == oldTargetLanguage ? oldSourceLanguage : oldTargetLanguage
                if newTargetLanguage != self.targetLanguage.value {
                    self.targetLanguage.accept(newTargetLanguage)
                }
                let newBindLanguage = LanguageBind(source: newSourceLanguage, target: newTargetLanguage)
                self.language.accept(newBindLanguage)
            })
            .disposed(by: disposeBag)
        
        targetLanguage
            .filter({ [weak self] (targetLanguage) -> Bool in
                guard let self = self else { return false }
                return self.language.value.targetLanguage != targetLanguage
            })
            .subscribe(onNext: { [weak self] (newTargetLanguage) in
                guard let self = self else { return }
                let oldSourceLanguage = self.language.value.sourceLanguage
                let oldTargetLanguage = self.language.value.targetLanguage
                let newSourceLanguage = newTargetLanguage == oldSourceLanguage ? oldTargetLanguage : oldSourceLanguage
                if newSourceLanguage != self.sourceLanguage.value {
                    self.sourceLanguage.accept(newSourceLanguage)
                }
                let newBindLanguage = LanguageBind(source: newSourceLanguage, target: newTargetLanguage)
                self.language.accept(newBindLanguage)
            })
            .disposed(by: disposeBag)
        
        callBackLanguage
            .compactMap{ $0 }
            .bind(to: self.targetLanguage)
            .disposed(by: disposeBag)
    }
    
    func bind(withNewPhrase newPhrase: ControlProperty<String>,
              translation: ControlProperty<String>,
              saveButtonPressed: ControlEvent<Void>,
              cancelButtonPressed: ControlEvent<Void>,
              removeButtonPressed: ControlEvent<Void>) {
        
        if mode.value == .edit, let card = card {
            newPhrase.onNext(card.sourcePhrase)
            translation.onNext(card.targetPhrase)
        }
        
        let inputData = Observable.combineLatest(newPhrase, translation)
        saveButtonPressed
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (newPhrase, translation) in
                guard !newPhrase.isEmpty, !translation.isEmpty else {
                    self?.alertModel.accept(.warningAlert(message: "Fill in all the fields", handler: nil))
                    return
                }
                
                guard let self = self else { return }
                
                guard self.mode.value == .create else {
                    if let card = self.card, card.sourcePhrase != newPhrase || card.targetPhrase != translation {
                        self.updateCard(sourcePhrase: newPhrase, targetPhrase: translation, card: card)
                    }
                    return
                }
                let translateCard = TranslateCard(userId: self.userId,
                                                  language: self.language.value,
                                                  sourcePhrase: newPhrase,
                                                  targetPhrase: translation)
                self.saveTranslationCard(card: translateCard)
            })
            .disposed(by: disposeBag)
        
        cancelButtonPressed
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
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
    }
    
    func bind(withSourceSelectLanguageButton sourceLanguageButton: ControlEvent<Void>,
                          targetSelectLanguageButton: ControlEvent<Void>) {
        
        targetSelectLanguageButton
            .withLatestFrom(mode)
            .filter{ $0 == .create }
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                let targetLanguages = Language.allCases.filter{ $0 != self.sourceLanguage.value}
                self.callBackLanguage.accept(self.targetLanguage.value)
                self.router.route(to: .languagePickerView(currentLanguage: self.callBackLanguage,
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
    fileprivate func updateCard(sourcePhrase: String, targetPhrase: String, card: TranslateCard) {
        guard sourcePhrase != card.sourcePhrase || targetPhrase != card.targetPhrase else {
            return
        }
        self.startActivityIndicator.accept(true)
        card.update(sourcePhrase: sourcePhrase, targetPhrase: targetPhrase)
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
                self?.startActivityIndicator.accept(false)
                }, onError: { [weak self] (error) in
                    self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: nil))
                    self?.startActivityIndicator.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func removeCard(_ card: TranslateCard) {
        self.startActivityIndicator.accept(true)
        card.remove().subscribe(onNext: { [weak self] (_) in
            self?.router.dissmis()
            self?.startActivityIndicator.accept(false)
        }, onError: { [weak self] (error) in
            self?.startActivityIndicator.accept(false)
            self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: { [weak self] (_) in
                self?.router.dissmis()
            }))
        })
        .disposed(by: disposeBag)
    }
    
    fileprivate func saveTranslationCard(card: TranslateCard) {
        self.startActivityIndicator.accept(true)
        card.save()
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
                self?.startActivityIndicator.accept(false)
                }, onError: { [weak self] (error) in
                    self?.startActivityIndicator.accept(false)
                    self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: { (_) in
                        self?.router.dissmis()
                    }))
                })
            .disposed(by: disposeBag)
    }
}
