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
    fileprivate let language: LanguageBind
    
    init(userId: String, language: LanguageBind) {
        self.userId = userId
        self.language = language
    }
    
    func bind(withNewPhrase newPhrase: ControlProperty<String>,
              translation: ControlProperty<String>,
              saveButtonPressed: ControlEvent<Void>) {
        
        let inputData = Observable.combineLatest(newPhrase, translation)
        saveButtonPressed
            .withLatestFrom(inputData)
            .subscribe(onNext: { [weak self] (newPhrase, translation) in
                guard !newPhrase.isEmpty, !translation.isEmpty,
                    let userId = self?.userId, let language = self?.language else { return }
                let translateCard = TranslateCard(userId: userId,
                                                  language: language,
                                                  sourcePhrase: newPhrase,
                                                  targetPhrase: translation)
                self?.saveTranslationCard(card: translateCard)
            })
            .disposed(by: disposeBag)
    }
    
//    func bindTapGesture(event: ControlEvent<UITapGestureRecognizer>) {
//        event.subscribe(onNext: { [weak self] (tap) in
//            self?.router.dissmis() })
//            .disposed(by: disposeBag)
//    }
//    
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
