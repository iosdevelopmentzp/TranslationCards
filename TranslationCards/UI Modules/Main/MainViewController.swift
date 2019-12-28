//
//  MainViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


final class MainViewController: ViewController<MainRouter, MainViewModel> {
    fileprivate let tableView = UITableView()
    fileprivate let signOutBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: nil, action: nil)
    private  var dataSource: RxTableViewSectionedReloadDataSource<MainViewModel.Section>?
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.typeName)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MainViewModel.Section>(configureCell: {
            (_, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.typeName,
                                                     for: indexPath)
            guard let languageCell = cell as? LanguageCell else {
                return cell
            }
            languageCell.configure(withLanguage: item)
            return languageCell })
        self.dataSource = dataSource
        
        viewModel
            .sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: true) })
            .disposed(by: disposeBag)
    }
    
    override func setupView() {
        super.setupView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = signOutBarButtonItem
    }
    
    override func binding() {
        super.binding()
        viewModel.bind(logoutEvent: signOutBarButtonItem.rx.tap)
        viewModel.bindSelectesItemEvent(tableView.rx.itemSelected)
    }
    
    override func localizable() {
        super.localizable()
        navigationItem.title = "My Cards"
    }
}
