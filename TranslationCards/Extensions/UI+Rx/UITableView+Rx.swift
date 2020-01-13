//
//  UITableView+Rx.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 13.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    /// Bindable sink for cell types registration.
    var cellTypes: Binder<[AnyClass]> {
        return Binder(self.base) { tableView, cells in
            for cell in cells {
                tableView.register(cell.self as AnyClass,
                                   forCellReuseIdentifier: String(describing: cell.self))
            }
        }
    }
}
