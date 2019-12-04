//
//  Screens.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

struct Screens {
    static func cardSlideShow(cards: [TranslateCard]) -> CardSlideShowViewController {
        let vm = CardSlideShowViewModel(cards: cards)
        return CardSlideShowViewController(viewModel: vm)
    }
    
    static func cardsList(withLanguage language: LanguageBind, forUserId userId: String) -> CardsListViewController {
        let vm = CardsListViewModel(language: language, userId: userId)
        return CardsListViewController(viewModel: vm)
    }
    
    static func createCard(forUserId userId: String, language: LanguageBind) -> CreateCardPopUpViewController {
        let vm = CreateCardPopUpViewModel(userId: userId, language: language)
        return CreateCardPopUpViewController(viewModel: vm)
    }
    
    static func main() -> MainViewController {
        let vm = MainViewModel()
        return MainViewController(viewModel: vm)
    }
    
    static func navigation(root: UIViewController) -> MainNavigationViewController {
        let vm = MainNavigationViewModel(root: root)
        return MainNavigationViewController(viewModel: vm)
    }
    
    static func logIn() -> LogInViewController {
        let vm = LogInViewModel()
        return LogInViewController(viewModel: vm)
    }
    
    static func signUp() -> SignUpViewController {
        let vm = SignUpViewModel()
        return SignUpViewController(viewModel: vm)
    }
}
