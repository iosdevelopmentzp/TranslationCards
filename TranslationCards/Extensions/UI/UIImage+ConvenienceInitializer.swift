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
    case to
    case speaker
    case plus
    case plus1
    case edit
    case leftArrow
    case `switch`
    case archived
    case move
    case translate
    case copy
    case reverse
    case shuffle
    case write
    case dotArrow
    case xButton
}

extension UIImage {
    static func flagIcon(forLanguage language: Language) -> UIImage? {
        let imageName = "\(language.rawValue)" + "Icon"
        return UIImage(named: imageName)
    }
    
    static func image(withType type: ImageType, renderringMode: RenderingMode = .alwaysTemplate) -> UIImage {
        guard let image = UIImage(named: type.rawValue) else {
            fatalError("Failed create image with name \(type.rawValue)")
        }
        return image.withRenderingMode(renderringMode)
    }
}
