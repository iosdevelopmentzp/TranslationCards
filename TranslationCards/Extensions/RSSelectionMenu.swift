//
//  RSSelectionMenu.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxCocoa
import RSSelectionMenu

extension RSSelectionMenu where T == Playlist {
    static func initWith(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>) -> RSSelectionMenu<Playlist> {
        let menu = RSSelectionMenu<Playlist>(selectionStyle: .multiple, dataSource: dataSource) { (cell, item, indexPath) in
            cell.textLabel?.text = item.name
        }
        menu.dismissAutomatically = false
        menu.cellSelectionStyle = .checkbox
        menu.setSelectedItems(items: selected.value) { (_, _, _, _) in }
        menu.uniquePropertyName = "name"
        
        debugPrint(dataSource.first!)
        
        menu.onDismiss = { [weak selected] selectedItems in
            selected?.accept(selectedItems)
        }
        return menu
    }
}
 

