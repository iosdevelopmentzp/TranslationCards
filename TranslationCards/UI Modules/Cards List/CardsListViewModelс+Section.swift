//
//  CardsListViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxDataSources

class CardsListViewModelCell: Equatable, IdentifiableType {

    var identity: String {
        return item.id
    }

    var item: TranslateCard

    init(item: TranslateCard) {
        self.item = item
    }

    static func == (lhs: CardsListViewModelCell, rhs: CardsListViewModelCell) -> Bool {
        return lhs.item.id == rhs.item.id
    }
}

struct CardsListViewModelSection {
    var header: String
    var items: [CardsListViewModelCell]
}

extension CardsListViewModelSection: AnimatableSectionModelType {
    var identity: String {
        return header
    }
    
    init(original: CardsListViewModelSection, items: [CardsListViewModelCell]) {
        self = original
        self.items = items
    }
}
