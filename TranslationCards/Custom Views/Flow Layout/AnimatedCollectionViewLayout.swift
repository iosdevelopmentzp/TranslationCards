//
//  AnimatedCollectionViewLayout.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class AnimatedCollectionViewLayout: UICollectionViewFlowLayout {
    var animator: LayoutAttributesAnimator?
    override class var layoutAttributesClass: AnyClass { return AnimatedCollectionViewLayoutAttributes.self}
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil}
        return attributes.compactMap{ $0.copy() as? AnimatedCollectionViewLayoutAttributes}.map { self.transformLayoutAttributes($0)}
    }
    
    // MARK: - Private
    private func transformLayoutAttributes(_ attributes: AnimatedCollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        var distance: CGFloat
        var itemOffset: CGFloat
        
        if scrollDirection == .horizontal {
            distance = collectionView.frame.width
            itemOffset = attributes.center.x - collectionView.contentOffset.x
            attributes.startOffset = (attributes.frame.origin.x - collectionView.contentOffset.x) / attributes.frame.width
            attributes.endOffset = (attributes.frame.origin.x - collectionView.contentOffset.x - collectionView.frame.width) / attributes.frame.width
        } else {
            distance = collectionView.frame.height
            itemOffset = attributes.center.y - collectionView.contentOffset.y
            attributes.startOffset = (attributes.frame.origin.y - collectionView.contentOffset.y) / attributes.frame.height
            attributes.endOffset = (attributes.frame.origin.y - collectionView.contentOffset.y - collectionView.frame.height) / attributes.frame.height
        }
        attributes.scrollDirection = scrollDirection
        attributes.middleOffset = itemOffset / distance - 0.5
        
        if attributes.contentView == nil,
            let contentView = collectionView.cellForItem(at: attributes.indexPath)?.contentView {
            attributes.contentView = contentView
        }
        animator?.animate(collectionView: collectionView, attributes: attributes)
        return attributes
    }
}
