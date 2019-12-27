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

extension UIViewController {
    @discardableResult
    func appendBlurEffect(style: UIBlurEffect.Style) -> UIVisualEffectView? {
        guard !UIAccessibility.isReduceTransparencyEnabled else {
            return nil
        }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        return blurEffectView
        
    }
    
    func getBlurEffect() -> UIVisualEffectView? {
        let blurView = view.subviews.first { $0 is UIVisualEffectView }
        return blurView as? UIVisualEffectView
    }
    
    var isTopOfNavigationStack: Bool {
        guard let naviagation = navigationController,
            let topViewController = naviagation.viewControllers.last else {
            return false
        }
        return topViewController === self
    }
}

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
            cell.detailTextLabel?.text = "\(item.dateUpdated.asString(dateFormat: "MM/dd/yyyy"))"
            cell.textLabel?.numberOfLines = 0
        }
        menu.dismissAutomatically = firstRowCallBack == nil
        menu.uniquePropertyName = "name"
        menu.rightBarButtonTitle = ""
        menu.title = "Choose a playlist"
        menu.onDismiss = { (selectedItems) in
            guard let playlist = selectedItems.first else { return }
            selectedAction(playlist)
        }
        
        if let selected = currentSelect {
            menu.setSelectedItems(items: [selected]) { [weak menu] (playlist, index, isSelected, selectedPlaylist) in
                menu?.tableView?.visibleCells.forEach{ $0.isSelected = false }
            }
        }
        
        if let firstRowTitle = firstRowTitle, let callBack = firstRowCallBack {
            menu.addFirstRowAs(rowType: .custom(value: firstRowTitle), showSelected: false) { (value, isSelected) in
                menu.dismiss(animated: true) {
                    callBack()
                }
            }
        }
        menu.show(style: .present, from: self)
    }
}
