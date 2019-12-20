//
//  TextFieldAlertBuilder.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class TextFieldAlertBuilder {
    static func buildTextFieldAlert(for model: TextFieldAlertModel) -> UIAlertController {
        let alertController = UIAlertController(title: model.title, message: nil, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        let okAction = UIAlertAction(title: model.okTile, style: .default) { [weak alertController] (_) in
            guard let textField = alertController?.textFields?.first,
                let text = textField.text else {
                    model.okHandler("")
                    return
            }
            model.okHandler(text)
        }
        alertController.addAction(okAction)
        
        if let cancelTitle = model.cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
                model.cancelHandler?()
            }
            alertController.addAction(cancelAction)
        }
        return alertController
    }
}
