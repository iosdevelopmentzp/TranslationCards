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
        addRefreshController(refreshControl, toScrollView: view)
        refreshControl.addTarget(self, action: #selector(refreshControlDidRefresh(_: )), for: .valueChanged)
    }
    
    // MARK: - Private
    private func addRefreshController(_ refreshControl: UIRefreshControl, toScrollView scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView else {
            scrollView.addSubview(refreshControl)
            return
        }
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
        else {
            tableView.backgroundView = refreshControl
        }
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
