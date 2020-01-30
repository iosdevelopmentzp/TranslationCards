//
//  UIViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RSSelectionMenu
import RxSwift
import RxCocoa

// Select menu view controller
extension UIViewController {
    func presentPlaylistSelectionMenu(dataSource: [Playlist], selected: BehaviorRelay<[Playlist]>) {
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
        menu.show(style: .present, from: self)
    }
    
    func presentSingleChoicePlaylist(dataSource: [Playlist],
                                     selectedAction: @escaping PlaylistCallBack,
                                     currentSelect: Playlist? = nil,
                                     firstRowTitle: String? = nil,
                                     firstRowCallBack: EmptyCallBack? = nil) {
        let menu = RSSelectionMenu<Playlist>(selectionStyle: .single, dataSource: dataSource, cellType: .rightDetail) { (cell, item, indexPath) in
            cell.textLabel?.text =  item.name
            cell.textLabel?.numberOfLines = 0
        }
        menu.dismissAutomatically = firstRowCallBack == nil
        menu.uniquePropertyName = "name"
        menu.rightBarButtonTitle = ""
        menu.title = "Choose a playlist"
        
        let currentSelectItems = [currentSelect].compactMap{ $0 }
        menu.setSelectedItems(items: currentSelectItems) { [weak menu] (item, index, isSelected, selectedItems) in
            if let item = item {
                selectedAction(item)
                menu?.dismiss()
            }
        }
        
        if let firstRowTitle = firstRowTitle, let callBack = firstRowCallBack {
            menu.addFirstRowAs(rowType: .custom(value: firstRowTitle), showSelected: false) { (value, isSelected) in
                if isSelected {
                    menu.dismiss(animated: true) {
                        callBack()
                    }
                }
            }
        }
        menu.show(style: .present, from: self)
    }
}
