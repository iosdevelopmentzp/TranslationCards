//
//  PickerViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxCocoa
import RxSwift

final class PickerViewModel: ViewModel<PickerRouter> {
    
    let items: BehaviorRelay<[String]> = .init(value: [])
    let selectedItem = BehaviorRelay<(row: Int, component: Int)>.init(value: (0,0))
    let title = BehaviorRelay<String>.init(value: "")
    private let finishLanguage = BehaviorRelay<Language?>.init(value: nil)
    private let currentLanguage = BehaviorRelay<Language?>.init(value: nil)
    
    init(callBackLanguage: BehaviorRelay<Language?>, languageList: [Language]? =  nil,titleLabel: String) {
        super.init()
        
        currentLanguage.accept(callBackLanguage.value)
        
        var supportedLanguages = languageList ?? Language.allCases
        supportedLanguages.sort(by: {
            $0.description < $1.description
        })
        if let language = callBackLanguage.value, let initialSelectedRow = supportedLanguages.firstIndex(of: language) {
            selectedItem.accept((row: initialSelectedRow, component: 0))
        }
        let newItems = supportedLanguages.map{ $0.description }
        items.accept(newItems)
        
        selectedItem
            .subscribe(onNext: { [weak self] (selectedItem) in
                let language = supportedLanguages[selectedItem.row]
                self?.currentLanguage.accept(language)
            })
            .disposed(by: disposeBag)
        
        finishLanguage
            .unwrap()
            .subscribe(onNext: { [weak callBackLanguage] (language) in
                callBackLanguage?.accept(language)
            })
            .disposed(by: disposeBag)
        
        title.accept(titleLabel)
    }
    
    func bind(cancelAction: ControlEvent<Void>, doneAction: ControlEvent<Void>) {
        cancelAction
            .subscribe(onNext: { [weak self] (_) in
                self?.router.comeBack()
            })
            .disposed(by: disposeBag)
        
        doneAction
            .subscribe(onNext: { [weak self] (_) in
                guard let currentLanguage = self?.currentLanguage.value else {
                    return
                }
                self?.finishLanguage.accept(currentLanguage)
                self?.router.comeBack() })
            .disposed(by: disposeBag)
    }
}
