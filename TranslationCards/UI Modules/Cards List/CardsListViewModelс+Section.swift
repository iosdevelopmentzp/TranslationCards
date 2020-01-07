//
//  CardsListViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxDataSources

extension CardsListViewModel {

    enum CellType {
        case `default`
    }

    class Cell: Equatable, IdentifiableType {

        var identity: String {
            return item.id
        }

        var item: TranslateCard
        private (set) var type: CellType = .default

        init(item: TranslateCard) {
            self.item = item
        }

        static func == (lhs: CardsListViewModel.Cell, rhs: CardsListViewModel.Cell) -> Bool {
            return lhs.item.id == rhs.item.id
        }
    }
    
    struct Section {
        var header: String
        var items: [Cell]
    }
}

extension CardsListViewModel.Section: AnimatableSectionModelType {
    var identity: String {
        return header
    }
    
    init(original: CardsListViewModel.Section, items: [CardsListViewModel.Cell]) {
        self = original
        self.items = items
    }
}
