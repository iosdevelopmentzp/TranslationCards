//
//  CardsListViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import RxDataSources
import JJFloatingActionButton

final class CardsListViewController: ViewController<CardsListRouter, CardsListViewModel> {
    fileprivate let tableView = UITableView()
    fileprivate lazy var refreshHandler = RefreshHandler(view: tableView)
    fileprivate let startCardSlideShowButton = JJActionItem.initWith(imageType: .playButton)
    fileprivate let startWritePhraseSlideShowButton = JJActionItem.initWith(imageType: .write)
    fileprivate let switchEditModeButton = JJActionItem.initWith(imageType: .xButton, renderringMode: .alwaysOriginal)
    fileprivate let choicePlaylistButton = UIButton(type: .custom)
    fileprivate var reverseButton = UIButton(type: .custom)
    fileprivate var shuffleButton = UIButton(type: .custom)
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    fileprivate lazy var dataSource: RxTableViewSectionedAnimatedDataSource<CardsListViewModel.Section> = {
        let animationConfiguration = AnimationConfiguration(insertAnimation: .right, reloadAnimation: .fade, deleteAnimation: .left)
        let dataSource = RxTableViewSectionedAnimatedDataSource<CardsListViewModel.Section>(animationConfiguration: animationConfiguration, decideViewTransition: { [weak self] (_, tableView, changeSet) -> ViewTransition in
            return self?.transition(forChangeSet: changeSet) ?? .reload
        },  configureCell: { [weak self] (_, tableView, indexPath, cellModel) -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.typeName, for: indexPath)
            self.configureCell(cell, withCellModel: cellModel, isReverse: self.viewModel.reverseMode.value)
            return cell
        })
        
        dataSource.canEditRowAtIndexPath = { [weak self] dataSource, indexPath in
            return self?.viewModel.isEditMode.value ?? false
        }
        return dataSource
    }()
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.typeName)
        
        viewModel
            .sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .execute({ [weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .bind(to: viewModel.didSelectedItemEvent)
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemDeleted
            .asObservable()
            .bind(to: viewModel.deleteIndexPath)
            .disposed(by: disposeBag)
    }
    
    override func setupView() {
        super.setupView()
        // choise button
        choicePlaylistButton.backgroundColor = .red
        
        // table view
        tableView.backgroundColor = .clear
        
        // reverse button
        let reverseImage = UIImage.image(withType: .reverse).scaledToSize(.init(width: 25.0, height: 25.0))
        reverseButton.setImage(reverseImage, for: .normal)
        reverseButton.isSelected = false
        
        // shuffle button
        let shaffleImage = UIImage.image(withType: .shuffle).scaledToSize(.init(width: 25.0, height: 25.0))
        shuffleButton.setImage(shaffleImage, for: .normal)
        shuffleButton.isSelected = false
        
        // nav buttons tint color
        updateNavigationButtonsTintColor()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.tintColor = .white
        
        let reverseButtonItem = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
        reverseButtonItem.customView = self.reverseButton
        let shuffleButtonItem = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
        shuffleButtonItem.customView = shuffleButton
        navigationItem.rightBarButtonItems = [reverseButtonItem, shuffleButtonItem]
    }
    
    override func localizable() {
        super.localizable()
        viewModel
            .titleText
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        startCardSlideShowButton.titleLabel.text = "Start slide show"
        startWritePhraseSlideShowButton.titleLabel.text = "Start write slide show"
        switchEditModeButton.titleLabel.text = "Switch edit mode"
        choicePlaylistButton.setTitle("Choose playlist", for: .normal)
    }
    
    override func binding() {
        super.binding()
        viewModel.bindWith(startSlideShowButtonPressed: startCardSlideShowButton.rx.tap)
        viewModel.bindWith(playlistsSelectionEvent: choicePlaylistButton.rx.tap)
        viewModel.bindWith(writePhraseSlideShowPressed: startWritePhraseSlideShowButton.rx.tap)
        viewModel.bindWith(switchEditModePressed: switchEditModeButton.rx.tap)
        
        refreshHandler.refresh
            .subscribe(onNext: { [weak self] (_) in
                self?.viewModel.fetchData.accept(()) })
            .disposed(by: disposeBag)
        
        viewModel
            .isFetchInProgress
            .subscribe(onNext: {[weak self] (isInProgress) in
                isInProgress ? self?.refreshHandler.begin() : self?.refreshHandler.end()
            })
            .disposed(by: disposeBag)
        
        viewModel.bindWith(changeReverseState: reverseButton.rx.tap, changeShuffleState: shuffleButton.rx.tap)
        
        viewModel
            .reverseMode
            .subscribe(onNext: { [weak self] (isReverse) in
                self?.reverseButton.isSelected = isReverse
                self?.updateNavigationButtonsTintColor()
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .shuffleMode
            .subscribe(onNext: { [weak self] (isShuffle) in
                self?.shuffleButton.isSelected = isShuffle
                self?.updateNavigationButtonsTintColor()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .isEditMode
            .subscribe(onNext: { [weak self] (isEditMode) in
                self?.tableView.setEditing(isEditMode, animated: true)
            })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func transition(forChangeSet set: [Changeset<CardsListViewModel.Section>]) -> ViewTransition {
        var isAnimate: ViewTransition = .animated
        let sectionWhereChangeItemsMoreThenOne = set.first{ $0.insertedItems.count > 1 || $0.deletedItems.count > 1 || $0.updatedItems.count > 1 }
        if sectionWhereChangeItemsMoreThenOne != nil {
            isAnimate = .reload
        }
        return isAnimate
    }
    
    fileprivate func configureCell(_ cell: UITableViewCell, withCellModel cellModel: CardsListViewModel.Cell, isReverse: Bool) {
        let currentLanguage = isReverse ? cellModel.item.language.targetLanguage : cellModel.item.language.sourceLanguage
        cell.imageView?.image = currentLanguage.flagIcon?.scaledToSize(.init(width: 30.0, height: 30.0), renderringMode: .alwaysOriginal)
        cell.textLabel?.text = isReverse == true ? cellModel.item.targetPhrase : cellModel.item.sourcePhrase
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
    }
    
    fileprivate func updateNavigationButtonsTintColor() {
        reverseButton.tintColor = self.reverseButton.isSelected ? .white : .innactiveButtonTitleColor
        shuffleButton.tintColor = self.shuffleButton.isSelected ? .white : .innactiveButtonTitleColor
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
        return [startCardSlideShowButton, startWritePhraseSlideShowButton, switchEditModeButton]
    }
}
