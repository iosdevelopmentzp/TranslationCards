//
//  CreateCardViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class CreateCardPopUpViewModel: ViewModel<CreateCardPopUpRouter> {
    
    fileprivate let userId: String
    fileprivate let startedLanguage: LanguageBind
    
    fileprivate lazy var language = BehaviorRelay<LanguageBind>.init(value: startedLanguage)
    fileprivate lazy var sourceLanguage = BehaviorRelay<Language>.init(value: language.value.sourceLanguage)
    fileprivate lazy var targetLanguage = BehaviorRelay<Language>.init(value: language.value.targetLanguage)
    
    init(userId: String, language: LanguageBind?) {
        self.userId = userId
        self.startedLanguage = language ?? LanguageBind.default
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
    }
    
    func bind(withNewPhrase newPhrase: ControlProperty<String>,
              translation: ControlProperty<String>,
              saveButtonPressed: ControlEvent<Void>,
              cancelButtonPressed: ControlEvent<Void>) {
        
        let inputData = Observable.combineLatest(newPhrase, translation)
        saveButtonPressed
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (newPhrase, translation) in
                guard !newPhrase.isEmpty, !translation.isEmpty,
                    let userId = self?.userId, let language = self?.language else { return }
                let translateCard = TranslateCard(userId: userId,
                                                  language: language.value,
                                                  sourcePhrase: newPhrase,
                                                  targetPhrase: translation)
                self?.saveTranslationCard(card: translateCard)
            })
            .disposed(by: disposeBag)
        
        cancelButtonPressed
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
            })
            .disposed(by: disposeBag)
    }
    
    func bind(withSourceSelectLanguageButton sourceLanguageButton: ControlEvent<Void>,
                          targetSelectLanguageButton: ControlEvent<Void>) {

// NOTE: - Implement if need source language action
        /*
        sourceLanguageButton
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.router.route(to: .languagePickerView(currentLanguage: self.sourceLanguage,
                                                          title: "Source language")) })
            .disposed(by: disposeBag)
 */
        
        targetSelectLanguageButton
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                let targetLanguages = Language.allCases.filter{ $0 != self.sourceLanguage.value}
                self.router.route(to: .languagePickerView(currentLanguage: self.targetLanguage,
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
    fileprivate func saveTranslationCard(card: TranslateCard) {
        card.sendToDatabase()
            .subscribe(onNext: { [weak self] (_) in
                self?.router.dissmis()
                }, onError: { [weak self] (error) in
                    let description = "Failed save card with error - \(error.localizedDescription)"
                    debugPrint(description)
                    let okAction = AlertModel.ActionModel(title: "Ok",
                                                          style: .destructive) { (_) in
                            self?.router.dissmis()
                    }
                    let alertModel = AlertModel(actionModels: [okAction],
                                                title: description,
                                                message: nil,
                                                prefferedStyle: .alert)
                    self?.alertModel.accept(alertModel)
                })
            .disposed(by: disposeBag)
    }
}
