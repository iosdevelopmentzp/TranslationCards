//
//  PageAttributesAnimator.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

public struct PageAttributesAnimator: LayoutAttributesAnimator {
    
    var scaleRate: CGFloat
    
    init(scaleRate: CGFloat = 0.2) {
        self.scaleRate = scaleRate
    }
    
    func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
        let position = attributes.middleOffset
        let contentOffset = collectionView.contentOffset
        let itemOrigin = attributes.frame.origin
        let scaleFactor = scaleRate * min(position, 0) + 1.0
        var transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        var concatenatingTransform: CGAffineTransform
        if attributes.scrollDirection == .horizontal {
            concatenatingTransform = CGAffineTransform(translationX: position < 0 ? contentOffset.x - itemOrigin.x : 0,
                                                       y: 0)
        } else {
            concatenatingTransform = CGAffineTransform(translationX: 0,
                                                       y: position < 0 ? contentOffset.y - itemOrigin.y : 0)
        }
        transform = transform.concatenating(concatenatingTransform)
        attributes.transform = transform
        attributes.zIndex = attributes.indexPath.row
    }
}
