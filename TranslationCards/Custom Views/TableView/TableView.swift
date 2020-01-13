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
    /// Pass in this function a BehaviorRelay value that will be used as a signal that the update has started or ended, and will also be as a receiver, when the view gives a signal that you need to start the refresh.
    func reverseBindWithRefeshingBehavior(_ refreshingState: BehaviorRelay<Bool>) -> Disposable {
        setupRefreshHandler()
        
        let refreshReverseBindDisposable = (isRefreshing <-> refreshingState)
        
        let refreshSubscriptionDisposable =  isRefreshing
            .distinctUntilChanged()
            .filter{ !$0 }
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (_) in
                self?.refresh.endRefreshing()
            })
        return Disposables.create([refreshReverseBindDisposable, refreshSubscriptionDisposable])
    }
    
    // MARK: - Private
    private let isRefreshing: BehaviorRelay<Bool> = .init(value: false)
    private let refresh = UIRefreshControl()
    
    init() {
        super.init(frame: .zero, style: .plain)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setupRefreshHandler() {
        if #available(iOS 10.0, *) {
            refreshControl = refresh
        }
        else {
            backgroundView = refresh
        }
        refresh.addTarget(self, action: #selector(refreshControlDidRefresh(_: )), for: .valueChanged)
    }
    
    private func setupAppearance() {
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
