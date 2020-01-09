//
//  TableView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class TableView: UITableView {
    // MARK: - Public
    func bindWithViewModelIsRefreshSate(_ isRefreshingState: BehaviorRelay<Bool>) -> Disposable {
        setupRefreshHandler()
        
        let refreshingBindDispose = (isRefreshing <-> isRefreshingState)
        
        let refreshDisposable =  isRefreshing
            .distinctUntilChanged()
            .filter{ !$0 }
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (_) in
                debugPrint("Refresh ended")
                self?.refresh.endRefreshing()
            })
        return Disposables.create([refreshingBindDispose, refreshDisposable])
    }
    
    // MARK: - Private
    fileprivate let isRefreshing: BehaviorRelay<Bool> = .init(value: false)
    fileprivate let refresh = UIRefreshControl()
    fileprivate let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero, style: .plain)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    fileprivate func setupRefreshHandler() {
        if #available(iOS 10.0, *) {
            refreshControl = refresh
        }
        else {
            backgroundView = refresh
        }
        refresh.addTarget(self, action: #selector(refreshControlDidRefresh(_: )), for: .valueChanged)
    }
    
    fileprivate func setupAppearance() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44.0
        backgroundColor = .clear
        separatorStyle = .none
    }
    
    // MARK: - Action
    @objc func refreshControlDidRefresh(_ control: UIRefreshControl) {
            if isRefreshing.value == false {
                isRefreshing.accept(true)
            }
    }
}
