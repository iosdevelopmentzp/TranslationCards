//
//  SignUpViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

final class SignUpViewModel: ViewModel<SignUpRouter> {
    
    func pressedLogInButton() {
        router.route(to: .back)
    }
}