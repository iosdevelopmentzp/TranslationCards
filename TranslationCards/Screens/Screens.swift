//
//  Screens.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import RSSelectionMenu

struct Screens {
    
    static func writePhraseSlideShow(withCards cards: [TranslateCard],  withReverse: Bool) -> WritePhraseSlideShowViewController {
        let vm = WritePhraseSlideShowViewModel(cards: cards,withReverse: withReverse)
        return WritePhraseSlideShowViewController(viewModel: vm)
    }
    
    static func viewCard(withCard card: TranslateCard, user: User) -> CardDetailsViewController {
        let vm = CardDetailsViewModel(card: card, user: user)
        return CardDetailsViewController(viewModel: vm)
    }
    
    static func choosingNativeLanguage(forUser user: User) -> ChoosingLanguageViewController {
        let vm = ChoosingLanguageViewModel(user: user)
        return ChoosingLanguageViewController(viewModel: vm)
    }
    
    static func languagePickerView(callBackLanguage: BehaviorRelay<Language?>, languageList: [Language]? = nil, title: String) -> PickerViewController {
        let vm = PickerViewModel(callBackLanguage: callBackLanguage, languageList: languageList, titleLabel: title)
        let vc = PickerViewController(viewModel: vm)
        return vc
    }
    
    static func cardSlideShow(cards: [TranslateCard], withReverse: Bool = false) -> CardSlideShowViewController {
        let vm = CardSlideShowViewModel(cards: cards, withReverse: withReverse)
        return CardSlideShowViewController(viewModel: vm)
    }
    
    static func cardsList(withLanguage language: LanguageBind,  user: User) -> CardsListViewController {
        let vm = CardsListViewModel(language: language, user: user)
        return CardsListViewController(viewModel: vm)
    }
    
    static func editCard(forCard card: TranslateCard, forUser user: User) -> CreateCardPopUpViewController {
        let vm = CreateCardPopUpViewModel(withCard: card, user: user)
        return CreateCardPopUpViewController(viewModel: vm)
    }
    
    static func createCard(forUser user: User, withLanguage language: LanguageBind) -> CreateCardPopUpViewController {
        let vm = CreateCardPopUpViewModel(user: user, language: language)
        return CreateCardPopUpViewController(viewModel: vm)
    }
    
    static func mainScreen() -> MainViewController {
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
