//
//  CardSlideShowFlowLayout.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class CardSlideShowFlowLayout: UICollectionViewLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    override func prepare() {
        
    }
}
