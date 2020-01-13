//
//  UITableView+Rx.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 13.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UICollectionView {
    /// Bindable sink for cell types registration.
    var cellTypes: Binder<[AnyClass]> {
        return Binder(self.base) { collectionView, cells in
            for cell in cells {
                collectionView.register(cell.self as AnyClass,
                                        forCellWithReuseIdentifier: String(describing: cell.self))
            }
        }
    }
}
