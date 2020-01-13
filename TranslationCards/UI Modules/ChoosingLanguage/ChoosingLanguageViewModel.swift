//
//  ChoosingLanguageViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 12.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ChoosingLanguageViewModelInput {
    var choiceLanguageAction: PublishSubject<Void> { get }
    var nextButtonEvent: PublishSubject<Void> { get }
}

protocol ChoosingLanguageViewModelOutput {
    var languageImage: BehaviorRelay<UIImage?> { get }
    var languageTitle: BehaviorRelay<String> { get }
    var selectedLanguage: BehaviorRelay<Language?> { get }
}

protocol ChoosingLanguageViewModelType: ChoosingLanguageViewModelInput & ChoosingLanguageViewModelOutput {
    var input: ChoosingLanguageViewModelInput { get }
    var output: ChoosingLanguageViewModelOutput { get }
}

extension ChoosingLanguageViewModelType where Self: ChoosingLanguageViewModelInput & ChoosingLanguageViewModelOutput {
    var input: ChoosingLanguageViewModelInput { return self }
    var output: ChoosingLanguageViewModelOutput { return self }
}

final class ChoosingLanguageViewModel: ViewModel<ChoosingLanguageRouter>, ChoosingLanguageViewModelType, ChoosingLanguageViewModelInput, ChoosingLanguageViewModelOutput {
    
    let choiceLanguageAction = PublishSubject<Void>()
    let nextButtonEvent = PublishSubject<Void>()
    let selectedLanguage: BehaviorRelay<Language?> = .init(value: nil)
    let languageImage: BehaviorRelay<UIImage?> = .init(value: nil)
    let languageTitle: BehaviorRelay<String> = .init(value: "Select")
    
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init()
        
        selectedLanguage
            .map{ $0?.flagIcon }
            .bind(to: languageImage)
            .disposed(by: disposeBag)
        
        selectedLanguage
            .map{ $0?.description ?? "Select"}
            .bind(to: languageTitle)
            .disposed(by: disposeBag)
            
        choiceLanguageAction
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.router.route(to: .languagePicker(callBackLanguage: self.selectedLanguage,
                                                      titel: "Choose native language"))
            })
            .disposed(by: disposeBag)
        
        nextButtonEvent
            .withLatestFrom(selectedLanguage)
            .unwrap()
            .subscribe(onNext: { [weak self] (language) in
                self?.tryUpdateNativeLanguage(language)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func tryUpdateNativeLanguage(_ language: Language) {
        startActivityIndicator.accept(true)
        user.updateNativeLanguage(newLanguage: language)
            .subscribe(onNext: { [weak self] (_) in
                self?.router.route(to: .mainView)
                }, onError: { [weak self] (error) in
                    self?.startActivityIndicator.accept(false)
                    self?.errorHandler(description: "Failed attempt to update native language", error: error, withAlert: true)
            })
            .disposed(by: disposeBag)
    }
}
