//
//  AlertModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 02.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

struct AlertModel {
    struct ActionModel {
        var title: String?
        var style: UIAlertAction.Style
        var handler: ((UIAlertAction) -> ())?
    }
    
    var actionModels = [ActionModel]()
    var title: String?
    var message: String?
    var prefferedStyle: UIAlertController.Style
}
