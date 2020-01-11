//
//  JJFloatingActionButton.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import JJFloatingActionButton

extension JJActionItem {
    static func initWith(imageType: ImageType, renderringMode: UIImage.RenderingMode = .alwaysTemplate) -> JJActionItem {
        let item = JJActionItem()
        let image = UIImage.image(withType: imageType, renderringMode: renderringMode)
        item.buttonImage = image
        return item
    }
}

