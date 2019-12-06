//
//  CardSlideShowFlowLayout.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CardSlideShowFlowLayout: UICollectionViewLayout {
    
    private var cashe: [UICollectionViewLayoutAttributes] = []
    private let cellPadding: CGFloat = 10
    private var contentHeight: CGFloat {
        return calculateHeightOneItem()
    }
    private var contentWidth: CGFloat = 0

    // MARK: - Override methods
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cashe[indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        cashe.forEach { [weak self] in
            if $0.frame.intersects(rect) {
                visibleLayoutAttributes.append($0)
                self?.insertEffectsForAttributes($0, inRect: rect)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func prepare() {
        guard cashe.isEmpty, let collectionView = collectionView else { return }
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        let columnWidth = calculateWidthOneItem()
        let columnHeight = contentHeight
        
        var xOffset: [CGFloat] = []
        for item in 0..<numberOfItems {
            let offset = columnWidth * CGFloat(item)
            xOffset.append(offset)
        }
        let yOffset: CGFloat = 0.0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(row: item, section: 0)
            let frame = CGRect(x: xOffset[item],
                               y: yOffset,
                               width: columnWidth,
                               height: columnHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cashe.append(attributes)
        }
        
        contentWidth = CGFloat(numberOfItems) * columnWidth
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionViewBounds = self.collectionView?.bounds,
            let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds) else {
                return proposedContentOffset
        }
        
        let halfWidthOfVC = collectionViewBounds.size.width * 0.5
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
        var candidateAttribute : UICollectionViewLayoutAttributes?
        
        for attributes in attributesForVisibleCells {
            let candAttr : UICollectionViewLayoutAttributes? = candidateAttribute
            if let candAttr = candAttr {
                let a = attributes.center.x - proposedContentOffsetCenterX
                let b = candAttr.center.x - proposedContentOffsetCenterX
                if abs(a) < abs(b) {
                    candidateAttribute = attributes
                }
            } else {
                candidateAttribute = attributes
                continue
            }
        }
        
        if candidateAttribute != nil {
            return CGPoint(x: candidateAttribute!.center.x - halfWidthOfVC, y: proposedContentOffset.y);
        } else {
            return proposedContentOffset
        }
    }
    
    // MARK: Private
    fileprivate func calculateWidthOneItem() -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let inset = collectionView.contentInset
        return collectionView.bounds.width - (inset.left + inset.right)
    }
    
    fileprivate func calculateHeightOneItem() -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let inset = collectionView.contentInset
        return collectionView.bounds.height - (inset.top + inset.bottom)
    }
    
    fileprivate func insertEffectsForAttributes(_ attributes: UICollectionViewLayoutAttributes, inRect bounds: CGRect) {
        guard let currentOffset = collectionView?.contentOffset,
            let bounds = collectionView?.bounds,
            bounds.width > 0 else {
            return
        }
        let halfWidth = bounds.width / 2
        let centerOfScreen = currentOffset.x + halfWidth
        let centerItem = attributes.center.x
       
        let shiftFromCenter = abs(centerItem - centerOfScreen)
        let maximumShift = halfWidth + attributes.frame.width / 2
        var shiftFromCenterScale = shiftFromCenter / maximumShift
        shiftFromCenterScale = shiftFromCenterScale > 1 ? 1.0 : shiftFromCenterScale
        
        let minScale: CGFloat = 0.7
        let maxScale: CGFloat = 1.0
        let rangeScale = maxScale - minScale
        
        let minAlpha: CGFloat = 0.4
        let maxAlpha: CGFloat = 1.0
        let rangeAlpha = maxAlpha - minAlpha
        
        let itemScale = maxScale - (rangeScale * shiftFromCenterScale)
        let itemAlpha = maxAlpha - (rangeAlpha * shiftFromCenterScale)
        attributes.transform = CGAffineTransform.init(scaleX: itemScale, y: itemScale)
        attributes.alpha = itemAlpha
    }
}
