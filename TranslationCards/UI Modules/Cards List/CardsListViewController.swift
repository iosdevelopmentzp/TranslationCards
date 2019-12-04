//
//  CardsListViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class CardsListViewController: ViewController<CardsListRouter, CardsListViewModel> {
    fileprivate let tableView = UITableView()
    fileprivate let startCardSlideShowButton = UIButton.playButton
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        view.addSubview(startCardSlideShowButton)
        startCardSlideShowButton.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.width.height.equalTo(60.0)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30.0)
        }
    }
    
    override func setupTable() {
        super.setupTable()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        viewModel
            .cardsDataSource
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                (row, element, cell) in
                cell.textLabel?.text = "\(element.language.sourceLanguage) - \(element.sourcePhrase)\n\(element.language.targetLanguage) - \(element.targetPhrase)"
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.textColor = .white
                cell.backgroundColor = .clear
        }
        .disposed(by: disposeBag)
    }
    
    override func setupView() {
        super.setupView()
        tableView.backgroundColor = .clear
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func localizable() {
        super.localizable()
        viewModel
            .titleText
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
    
    override func binding() {
        super.binding()
        
        viewModel
            .bindWith(startSlideShowButtonPressed: startCardSlideShowButton.rx.tap)
    }
}
