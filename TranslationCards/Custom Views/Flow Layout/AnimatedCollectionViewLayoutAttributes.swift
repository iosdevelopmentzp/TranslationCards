//
//  AnimatedCollectionViewLayoutAttributes.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class AnimatedCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var contentView: UIView?
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    var startOffset: CGFloat = 0
    var middleOffset: CGFloat = 0
    var endOffset: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! AnimatedCollectionViewLayoutAttributes
        copy.contentView = contentView
        copy.scrollDirection = scrollDirection
        copy.startOffset = startOffset
        copy.middleOffset = middleOffset
        copy.endOffset = endOffset
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? AnimatedCollectionViewLayoutAttributes else { return false }
        
        return super.isEqual(object)
            && object.contentView == contentView
            && object.scrollDirection == scrollDirection
            && object.startOffset == startOffset
            && object.middleOffset == middleOffset
            && object.endOffset == endOffset
    }
}
