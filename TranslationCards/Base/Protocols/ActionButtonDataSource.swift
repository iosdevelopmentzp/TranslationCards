//
//  ActionButtonDataSource.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import JJFloatingActionButton

protocol ActionButtonDataSource {
    func getActionButtons() -> [JJActionItem]
}
