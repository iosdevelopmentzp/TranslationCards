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
    private let tableView = TableView()
    private let signOutBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: nil, action: nil)
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private let dataSource: RxTableViewSectionedReloadDataSource<MainViewModelSection> = {
        let dataSource = RxTableViewSectionedReloadDataSource<MainViewModelSection>(configureCell: {
            (_, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.typeName,
                                                     for: indexPath)
            guard let languageCell = cell as? LanguageCell else {
                return cell
            }
            languageCell.configure(withLanguage: item)
            return languageCell })
        return dataSource
    }()
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.typeName)
        
        viewModel
            .sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemSelected
            .execute({ [weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: true) })
            .subscribe(viewModel.input.selectedAction)
            .disposed(by: disposeBag)
        
        tableView
            .bindWithViewModelIsRefreshSate(viewModel.output.isRefreshing)
            .disposed(by: disposeBag)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = signOutBarButtonItem
    }
    
    override func binding() {
        super.binding()
        signOutBarButtonItem.rx
            .tap
            .bind(to: viewModel.input.signOutAction)
            .disposed(by: disposeBag)
    }
    
    override func localize() {
        super.localize()
        navigationItem.title = "My Cards"
    }
}
