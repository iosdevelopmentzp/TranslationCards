//
//  LanguageChoiceViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 12.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class LanguageChoiceViewModel: ViewModel<LanguageChoiceRouter> {
    
    let selectedLanguage: BehaviorRelay<Language?> = .init(value: nil)
    let languageImage: BehaviorRelay<UIImage?> = .init(value: nil)
    let languageTitle: BehaviorRelay<String> = .init(value: "Select")
    
    override init() {
        super.init()
        
        selectedLanguage
            .subscribe(onNext: { [weak self] (language) in
                let nextImage = language?.flagIcon?.scaledToSize(.init(width: 30.0, height: 30.0))
                let nextTitle = language?.description ?? "Select"
                self?.languageImage.accept(nextImage)
                self?.languageTitle.accept(nextTitle)
            })
            .disposed(by: disposeBag)
    }
    
    func bind(choiseLanguageButtonEvent: ControlEvent<Void>, nextButtonEvent: ControlEvent<Void>) {
        choiseLanguageButtonEvent
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.router.route(to: .languagePicker(callBackLanguage: self.selectedLanguage,
                                                      titel: "Choose native language")) })
            .disposed(by: disposeBag)
        
        nextButtonEvent
            .subscribe(onNext: { [weak self] (_) in
                guard let language = self?.selectedLanguage.value else {
                    self?.alertModel.accept(.warningAlert(message: "No language selected", handler: nil))
                    return
                }
                guard let user = self?.services.credentials.user.value else {
                    self?.alertModel.accept(.warningAlert(message: "User was not found", handler: nil))
                    return
                }
                self?.startActivityIndicator.accept(true)
                user.updateNativeLanguage(newLanguage: language)
                    .subscribe(onNext: { [weak self] (_) in
                            self?.router.route(to: .mainView)
                            self?.startActivityIndicator.accept(false)
                        }, onError: { [weak self] (error) in
                            self?.startActivityIndicator.accept(false)
                            self?.alertModel.accept(.warningAlert(message: error.localizedDescription, handler: nil)) })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
    }
}
