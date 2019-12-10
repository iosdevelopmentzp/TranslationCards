//
//  CreateCardRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CreateCardPopUpRouter: Router {
    
    enum Route {
        case languagePickerView(currentLanguage: BehaviorRelay<Language>, title: String)
    }
    
    func dissmis() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func route(to type: Route) {
        switch type {
        case .languagePickerView(let currentLanguage, let title):
            presentLanguagePicker(currentLanguage: currentLanguage,
                                  title: title)
        }
    }
    
    // MARK: - Private
    fileprivate func presentLanguagePicker(currentLanguage: BehaviorRelay<Language>, title: String) {
        let vc = Screens.languagePickerView(currentLanguage: currentLanguage, title: title)
        viewController?.present(vc, animated: true, completion: nil)
    }
}
