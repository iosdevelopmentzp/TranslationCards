//
//  CardSlideShowViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import JJFloatingActionButton

final class CardSlideShowViewController: ViewController<CardSlideShowRouter, CardSlideShowViewModel> {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = CardSlideShowFlowLayout()
    private let editCardItem = JJActionItem.initWith(imageType: .edit)
    private let moveCardToItem = JJActionItem.initWith(imageType: .move)
    private let copyCardToItem = JJActionItem.initWith(imageType: .copy)
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30.0)
        }
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        Observable.just([CardCell.self])
            .bind(to: collectionView.rx.cellTypes)
            .disposed(by: disposeBag)
        
        viewModel.cards.bind(to: collectionView.rx.items(cellIdentifier: CardCell.typeName, cellType: CardCell.self)) { [weak self] row,card,cell in
            guard let self = self else { return }
            cell.configure(withCard: card, withReverse: self.viewModel.output.isReverseMode.value)
            cell.speakData
                .skip(1)
                .unwrap()
                .bind(to: self.viewModel.speechData)
                .disposed(by: cell.rx.reuseBag)
        }
        .disposed(by: disposeBag)
    }
    
    override func binding() {
        super.binding()
        editCardItem
            .rx.tap
            .bind(to: viewModel.input.editCardButtonTap)
            .disposed(by: disposeBag)
        
        moveCardToItem
            .rx.tap
            .bind(to: viewModel.input.moveCardToButtonTap)
            .disposed(by: disposeBag)
        
        copyCardToItem
            .rx.tap
            .bind(to: viewModel.input.copyCardToButtonTap)
            .disposed(by: disposeBag)
        
        viewModel.getCurrentCentralCellIndexPath = { [weak self] in return self?.collectionView.indexPathOfCellWichInTheCenter()}
    }
    
    override func setupView() {
        super.setupView()
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
    }
    
    override func localize() {
        super.localize()
        editCardItem.titleLabel.text = "Edit card"
        moveCardToItem.titleLabel.text = "Move card to"
        copyCardToItem.titleLabel.text = "Copy card to"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.stopTextPlayback()
    }
}

extension CardSlideShowViewController: ActionButtonsDataSource {
    func getActionButtons() -> [JJActionItem] {
        return [editCardItem, moveCardToItem, copyCardToItem]
    }
}
