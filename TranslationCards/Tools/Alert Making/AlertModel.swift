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
    
    static func warningAlert(message: String?, handler: ((UIAlertAction) -> ())?) -> AlertModel {
        let okAction = ActionModel(title: "Ok", style: .default) { (action) in
            handler?(action)
        }
        return AlertModel(actionModels: [okAction], title: "Something went wrong", message: message, prefferedStyle: .alert)
    }
}
