//
//  TextFieldAlertModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

struct TextFieldAlertModel {
    var title: String
    var okTile: String
    var cancelTitle: String?
    var okHandler: StringCallBack = {(_) in}
    var cancelHandler: EmptyCallBack?
    
    static func createPlaylistModel(okAction: @escaping StringCallBack, cancelAction: @escaping EmptyCallBack) -> TextFieldAlertModel {
        let model = TextFieldAlertModel(title: "Set new playlist name", okTile: "Create", cancelTitle: "Cancel", okHandler: okAction, cancelHandler: cancelAction)
        return model
    }
}
