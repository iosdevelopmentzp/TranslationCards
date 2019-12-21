//
//  UICollectionView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 21.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    var currentCenterPoint: CGPoint {
        return CGPoint.init(x: center.x + contentOffset.x, y: center.y + contentOffset.y)
    }
    
    func centerCellIndexPath() -> IndexPath? {
        return indexPathForItem(at: currentCenterPoint)
    }
}
