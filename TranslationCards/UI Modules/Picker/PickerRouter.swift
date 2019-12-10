//
//  PickerRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

class PickerRouter: Router {
    enum Route {
        case dissmis
    }
    
    func route(to type: Route) {
        switch type {
        case .dissmis:
            viewController?.dismiss(animated: true, completion: nil)
        }
    }
}
