//
//  ChoosingLanguageRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 12.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class ChoosingLanguageRouter: Router {
    enum Route {
        case languagePicker(callBackLanguage: BehaviorRelay<Language?>, titel: String)
        case mainView
    }
    
    func route(to type: Route) {
        switch type {
        case .languagePicker(let callBack, titel: let title):
            let vc = Screens.languagePickerView(callBackLanguage: callBack, title: title)
            viewController?.present(vc, animated: true, completion: nil)
        case .mainView:
            let mainViewController = Screens.mainScreen()
            viewController?.navigationController?.setViewControllers([mainViewController], animated: true)
        }
    }
}
