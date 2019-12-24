//
//  RefreshHandler.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 24.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class RefreshHandler: NSObject {
    let refresh = PublishSubject<Void>()
    let refreshControl = UIRefreshControl()
    init(view: UIScrollView) {
        super.init()
        view.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlDidRefresh(_: )), for: .valueChanged)
    }
    // MARK: - Action
    @objc func refreshControlDidRefresh(_ control: UIRefreshControl) {
        refresh.onNext(())
    }
    
    func begin() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            guard !self.refreshControl.isRefreshing else  {
                return
            }
            self.refreshControl.beginRefreshing()
        }
    }
    
    func end() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            guard self.refreshControl.isRefreshing else  {
                return
            }
            self.refreshControl.endRefreshing()
        }
    }
}
