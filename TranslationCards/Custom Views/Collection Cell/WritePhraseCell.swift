//
//  WritePhrase.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class WritePhraseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        #if DEBUG
        backgroundColor = .random
        #endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
