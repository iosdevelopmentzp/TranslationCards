//
//  PickerViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxCocoa
import RxSwift

protocol PickerViewModelInput {
    var doneTap: PublishSubject<Void> { get }
    var cancelTap: PublishSubject<Void> { get }
    var selectedItem: BehaviorRelay<(row: Int, component: Int)> { get }
}

protocol PickerViewModelOutput {
    var items: BehaviorRelay<[String]> { get }
    var titleLabelText: BehaviorRelay<String> { get }
    var selectedItem: BehaviorRelay<(row: Int, component: Int)> { get }
}

protocol PickerViewModelType {
    var input: PickerViewModelInput { get }
    var output: PickerViewModelOutput { get }
}

extension PickerViewModelType where Self:  PickerViewModelInput & PickerViewModelOutput {
    var input: PickerViewModelInput { self }
    var output: PickerViewModelOutput { self }
}

final class PickerViewModel: ViewModel<PickerRouter>, PickerViewModelInput, PickerViewModelOutput, PickerViewModelType {
    
    let doneTap = PublishSubject<Void>()
    let cancelTap = PublishSubject<Void>()
    let selectedItem = BehaviorRelay<(row: Int, component: Int)>.init(value: (0,0))
    
    let items: BehaviorRelay<[String]> = .init(value: [])
    let titleLabelText: BehaviorRelay<String>

    init(callBackLanguage: BehaviorRelay<Language?>, languageList: [Language]? =  nil, titleLabel: String) {
        self.titleLabelText = .init(value: titleLabel)
        super.init()
        
        var languagesListDataSource = languageList ?? Language.allCases
        languagesListDataSource.sort(by: {
            $0.description < $1.description
        })
        
        if let language = callBackLanguage.value, let initialSelectedRow = languagesListDataSource.firstIndex(of: language) {
            selectedItem.accept((row: initialSelectedRow, component: 0))
        }
        
        let newItems = languagesListDataSource.map{ $0.description }
        items.accept(newItems)
        
        doneTap
            .withLatestFrom(selectedItem)
            .map { (selectedItem) -> Language in
                return languagesListDataSource[selectedItem.row] }
            .execute({ [weak self] (_) in
                self?.router.comeBack()
            })
            .bind(to: callBackLanguage)
            .disposed(by: disposeBag)
        
        cancelTap
            .subscribe(onNext: { [weak self] (_) in
                self?.router.comeBack()
            })
            .disposed(by: disposeBag)
    }
}
