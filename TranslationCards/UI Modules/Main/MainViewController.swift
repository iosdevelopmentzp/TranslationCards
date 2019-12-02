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
    fileprivate let addCardButton = PlusButton()
    fileprivate let tableView = UITableView()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        view.addSubview(addCardButton)
        addCardButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.width.height.equalTo(60.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30.0)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
        }
    }
    
    override func setupTable() {
        super.setupTable()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    override func setupView() {
        super.setupView()
        addCardButton.tintColor = .white
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.hidesBackButton = true
    }
    
    override func binding() {
        super.binding()
        viewModel.bind(addCardPressed: addCardButton.rx.tap)
    }
    
    override func localizable() {
        super.localizable()
        navigationItem.title = "My Cards"
    }
}
