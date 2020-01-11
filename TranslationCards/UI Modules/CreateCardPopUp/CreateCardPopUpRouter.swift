//
//  CreateCardRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import RSSelectionMenu

final class CreateCardPopUpRouter: Router {
    
    enum Route {
        case languagePickerView(currentLanguage: BehaviorRelay<Language?>, languageList: [Language]? = nil, title: String)
        case selectPlaylistView(dataSource: [Playlist], selectedAction: PlaylistCallBack, firstRowTitle: String, createNewPlaylistCallBack: EmptyCallBack)
    }
    
    func dissmis() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func route(to type: Route) {
        switch type {
        case .languagePickerView(let currentLanguage, let languageList, let title):
            presentLanguagePicker(currentLanguage: currentLanguage,
                                  languageList: languageList,
                                  title: title)
        case .selectPlaylistView(let dataSource,let selectedAction, let firstRowTitle, let callBack):
            viewController?.presentSingleChoicePlaylist(dataSource: dataSource, selectedAction: selectedAction, firstRowTitle: firstRowTitle, firstRowCallBack: callBack)
        }
    }
    
    // MARK: - Private
    private func presentLanguagePicker(currentLanguage: BehaviorRelay<Language?>, languageList: [Language]? = nil, title: String) {
        let vc = Screens.languagePickerView(callBackLanguage: currentLanguage, languageList: languageList, title: title)
        viewController?.present(vc, animated: true, completion: nil)
    }
}
