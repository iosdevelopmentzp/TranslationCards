//
//  CardsListViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import JJFloatingActionButton

final class CardsListViewController: ViewController<CardsListRouter, CardsListViewModel> {
    fileprivate let tableView = UITableView()
    fileprivate let startCardSlideShowButton = JJActionItem()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func setupTable() {
        super.setupTable()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        disposeBag.insert([
            
            tableView.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }),
            
            viewModel
                .cardsDataSource
                .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                    (row, element, cell) in
                    cell.imageView?.image = element.language.sourceLanguage.flagIcon?.scaledToSize(.init(width: 30.0, height: 30.0))
                    cell.textLabel?.text = element.sourcePhrase
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.textColor = .white
                    cell.backgroundColor = .clear },
            
            tableView
                .rx
                .itemSelected
                .bind(to: viewModel.selectedItem)
        ])
    }
    
    override func setupView() {
        super.setupView()
        tableView.backgroundColor = .clear
        
        startCardSlideShowButton.imageView.image = .image(withType: .playButton, renderringMode: .alwaysTemplate)
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
        
        startCardSlideShowButton.titleLabel.text = "Start slide show"
    }
    
    override func binding() {
        super.binding()
        
        viewModel
            .bindWith(startSlideShowButtonPressed: startCardSlideShowButton.rx.tap)
    }
}

extension CardsListViewController: ActionButtonDataSource {
    func getActionButtons() -> [JJActionItem] {
        return [startCardSlideShowButton]
    }
}
