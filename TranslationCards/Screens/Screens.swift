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
    
    static func viewCard(withCard card: TranslateCard, user: User) -> ViewCardViewController {
        let vm = ViewCardViewModel(card: card, user: user)
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
    
    static func cardsList(withLanguage language: LanguageBind,  user: User) -> CardsListViewController {
        let vm = CardsListViewModel(language: language, user: user)
        return CardsListViewController(viewModel: vm)
    }
    
    static func editCard(forCard card: TranslateCard, user: User) -> CreateCardPopUpViewController {
        let vm = CreateCardPopUpViewModel(withCard: card, user: user)
        return CreateCardPopUpViewController(viewModel: vm)
    }
    
    static func createCard(forUser user: User, language: LanguageBind) -> CreateCardPopUpViewController {
        let vm = CreateCardPopUpViewModel(user: user, language: language)
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
    
    // MARK: - Selection menu
    static func playlistSingleSelectionMenu(dataSource: [Playlist], selectedEvent: BehaviorRelay<Playlist?>, createNewPlaylistAction: @escaping EmptyCallBack) -> RSSelectionMenu<Playlist> {
        return RSSelectionMenu<Playlist>.initWithSingleChoiceAndCreateNewPlaylistAction(dataSource: dataSource, selectedEvent: selectedEvent, createNewPlaylistCallBack: createNewPlaylistAction)
    }
    
    static func playlistSelectionMenu(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>) -> RSSelectionMenu<Playlist> {
        return RSSelectionMenu<Playlist>.initWith(dataSource: dataSource, selected: selected)
    }
}
