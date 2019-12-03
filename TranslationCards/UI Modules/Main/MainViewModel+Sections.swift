//
//  MainViewModel+Sections.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxDataSources

extension MainViewModel {
    struct Section: SectionModelType {
        var items: [String]
        
        init(items: [String]) {
            self.items = items
        }
        
        init(original: Section, items: [String]) {
            self = original
            self.items = items
        }
    }
}


