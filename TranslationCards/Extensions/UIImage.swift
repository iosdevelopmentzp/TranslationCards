//
//  UIImage.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

enum ImageType: String {
    case playButton
}

extension UIImage {
    static func image(withType type: ImageType, renderringMode: RenderingMode = .alwaysTemplate) -> UIImage {
        guard let image = UIImage(named: type.rawValue) else {
            fatalError("Failed create image with name \(type.rawValue)")
        }
        return image.withRenderingMode(renderringMode)
    }
}
