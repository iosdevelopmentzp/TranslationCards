//
//  RSSelectionMenu.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RSSelectionMenu
import RxSwift
import RxCocoa

extension RSSelectionMenu where T == Playlist {
    static func initWith(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>) -> RSSelectionMenu<Playlist> {
        let menu = RSSelectionMenu<Playlist>(selectionStyle: .multiple, dataSource: dataSource) { (cell, item, indexPath) in
            cell.textLabel?.text = item.name
        }
        menu.dismissAutomatically = false
        menu.cellSelectionStyle = .checkbox
        menu.setSelectedItems(items: selected.value) { (_, _, _, _) in }
        menu.uniquePropertyName = "name"
        
        menu.onDismiss = { [weak selected] selectedItems in
            selected?.accept(selectedItems)
        }
        return menu
    }
    
    static func initWithSingleChoiceAndCreateNewPlaylistAction(dataSource: [Playlist], selectedEvent: BehaviorRelay<Playlist?>, createNewPlaylistCallBack: @escaping EmptyCallBack) -> RSSelectionMenu<Playlist> {
        let menu = RSSelectionMenu<Playlist>(selectionStyle: .single, dataSource: dataSource, cellType: .rightDetail) { (cell, item, indexPath) in
            cell.textLabel?.text = "\(indexPath.row) " + item.name
            cell.textLabel?.numberOfLines = 0
        }
        menu.dismissAutomatically = false
        menu.uniquePropertyName = "name"
        menu.onDismiss = { [weak selectedEvent] (selected) in
            guard let playlist = selected.first else { return }
            selectedEvent?.accept(playlist)
        }
        
        menu.addFirstRowAs(rowType: .custom(value: "Create new playlist"), showSelected: false) { [weak menu] (value, isSelected) in
            menu?.dismiss()
            createNewPlaylistCallBack()
        }
        
        return menu
    }
}
 

