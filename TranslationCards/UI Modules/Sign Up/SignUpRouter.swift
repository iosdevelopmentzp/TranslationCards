//
//  SignUpRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class SignUpRouter: Router {
    enum Router {
        case back
    }
    
    func route(to type: Router) {
        switch type {
        case .back:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
