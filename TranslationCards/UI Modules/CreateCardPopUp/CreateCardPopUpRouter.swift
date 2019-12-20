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

class CreateCardPopUpRouter: Router {
    
    enum Route {
        case languagePickerView(currentLanguage: BehaviorRelay<Language?>, languageList: [Language]? = nil, title: String)
        case selectPlaylistView(dataSource: [Playlist], selectedEvent: BehaviorRelay<Playlist?>, createNewPlaylistCallBack: EmptyCallBack)
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
        case .selectPlaylistView(let dataSource,let selectedEvent, let callBack):
            guard let vc = viewController else { return }
            let selectView = Screens.playlistSingleSelectionMenu(dataSource: dataSource, selectedEvent: selectedEvent, createNewPlaylistAction: callBack)
            selectView.show(style: .present, from: vc)
        }
    }
    
    // MARK: - Private
    fileprivate func presentLanguagePicker(currentLanguage: BehaviorRelay<Language?>, languageList: [Language]? = nil, title: String) {
        let vc = Screens.languagePickerView(callBackLanguage: currentLanguage, languageList: languageList, title: title)
        viewController?.present(vc, animated: true, completion: nil)
    }
}
