//
//  PickerRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

class PickerRouter: Router {
    override func comeBack() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
