//
//  MainViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModel<MainRouter> {
    
    func bind(plusButtonPressed plusPressed: ControlEvent<Void>) {
        plusPressed.subscribe() { [weak self] _ in
            self?.router.route(to: .createCard) }
        .disposed(by: disposeBag)
    }
}
