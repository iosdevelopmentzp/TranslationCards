//
//  Screens.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

struct Screens {
    static func viewCard(withCard card: TranslateCard) -> ViewCardViewController {
        let vm = ViewCardViewModel(card: card)
        return ViewCardViewController(viewModel: vm)
    }
    
    static func nativeLanguageChoise() -> LanguageChoiceViewController {
        let vm = LanguageChoiceViewModel()
        return LanguageChoiceViewController(viewModel: vm)
    }
    
    static func languagePickerView(callBackLanguage: BehaviorRelay<Language?>, languageList: [Language]? = nil, title: String) -> PickerViewController {
        let vm = PickerViewModel(callBackLanguage: callBackLanguage, languageList: languageList, titleLabel: title)
        let vc = PickerViewController(viewModel: vm)
        vc.transitioningDelegate = vc
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }
    
    static func cardSlideShow(cards: [TranslateCard]) -> CardSlideShowViewController {
        let vm = CardSlideShowViewModel(cards: cards)
        return CardSlideShowViewController(viewModel: vm)
    }
    
    static func cardsList(withLanguage language: LanguageBind, forUserId userId: String) -> CardsListViewController {
        let vm = CardsListViewModel(language: language, userId: userId)
        return CardsListViewController(viewModel: vm)
    }
    
    static func editCard(forCard card: TranslateCard) -> CreateCardPopUpViewController {
        let vm = CreateCardPopUpViewModel(withCard: card)
        return CreateCardPopUpViewController(viewModel: vm)
    }
    
    static func createCard(forUserId userId: String, language: LanguageBind) -> CreateCardPopUpViewController {
        let vm = CreateCardPopUpViewModel(userId: userId, language: language)
        return CreateCardPopUpViewController(viewModel: vm)
    }
    
    static func main() -> MainViewController {
        let vm = MainViewModel()
        return MainViewController(viewModel: vm)
    }
    
    static func navigation() -> MainNavigationViewController {
        let vm = MainNavigationViewModel()
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
