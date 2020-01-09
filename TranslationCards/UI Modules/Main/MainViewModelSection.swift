//
//  MainViewModel+Sections.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxDataSources


struct MainViewModelSection: SectionModelType {
    var items: [LanguageBind]
    
    init(items: [LanguageBind]) {
        self.items = items
    }
    
    init(original: MainViewModelSection, items: [LanguageBind]) {
        self = original
        self.items = items
    }
}



