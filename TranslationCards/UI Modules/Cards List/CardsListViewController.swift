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
    fileprivate let choicePlaylistButton = UIButton(type: .custom)
    
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
            
            tableView
                .rx
                .setDelegate(self),
            
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
                .bind(to: viewModel.didSelectedItemEvent)
        ])
    }
    
    override func setupView() {
        super.setupView()
        // startCardSlideShowButton
        startCardSlideShowButton.imageView.image = .image(withType: .playButton, renderringMode: .alwaysTemplate)
        // choise button
        choicePlaylistButton.backgroundColor = .red
        // table view
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
        
        startCardSlideShowButton.titleLabel.text = "Start slide show"
        choicePlaylistButton.setTitle("Choose playlist", for: .normal)
    }
    
    override func binding() {
        super.binding()
        
        viewModel.bindWith(startSlideShowButtonPressed: startCardSlideShowButton.rx.tap)
        viewModel.bindWith(playlistsSelectionEvent: choicePlaylistButton.rx.tap)
    }
}

extension CardsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        choicePlaylistButton.frame = .init(x: 0, y: 0, width: view.bounds.width, height: 40.0)
        return choicePlaylistButton
    }
}

extension CardsListViewController: ActionButtonDataSource {
    func getActionButtons() -> [JJActionItem] {
        return [startCardSlideShowButton]
    }
}
