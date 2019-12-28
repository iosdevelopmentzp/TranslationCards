//
//  JJFloatingActionButton.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import JJFloatingActionButton

extension JJFloatingActionButton {
    static var tunedButton: JJFloatingActionButton {
        let actionButton = JJFloatingActionButton()
        actionButton.handleSingleActionDirectly = false
        actionButton.buttonColor = .accentColor
        actionButton.itemAnimationConfiguration = .popUp()
        actionButton.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        actionButton.configureDefaultItem { (item) in
            JJActionItem.setupAppearance(forItem: item)
        }
        return actionButton
    }
}
