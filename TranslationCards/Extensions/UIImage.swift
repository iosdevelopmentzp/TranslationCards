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
    
    // Flags icons
    case engFlagIcon = "engIcon"
    case rusFlagIcon = "rusIcon"
}

extension UIImage {
    static func image(withType type: ImageType, renderringMode: RenderingMode = .alwaysTemplate) -> UIImage {
        guard let image = UIImage(named: type.rawValue) else {
            fatalError("Failed create image with name \(type.rawValue)")
        }
        return image.withRenderingMode(renderringMode)
    }
    
    func scaledToSize(_ newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
