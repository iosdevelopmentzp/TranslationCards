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
    
    fileprivate lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    fileprivate let flowLayout = CardSlideShowFlowLayout()
    
    fileprivate let editCardButton = JJActionItem.initWith(imageType: .edit)
    fileprivate let moveCardToButton = JJActionItem.initWith(imageType: .move)
    fileprivate let copyCardToButton = JJActionItem.initWith(imageType: .copy)
    
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
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.typeName)
        
        viewModel.cards.bind(to: collectionView.rx.items(cellIdentifier: CardCell.typeName, cellType: CardCell.self)) { [weak self] row,card,cell in
            guard let self = self else { return }
            cell.configure(withCard: card, withReverse: self.viewModel.reverseMode.value)
            cell.speakData
                .skip(1)
                .unwrap()
                .bind(to: self.viewModel.cellSpeechData)
                .disposed(by: cell.rx.reuseBag)
        }
        .disposed(by: disposeBag)
        
        viewModel.getSelectedCellIndexPath = { [weak self] in return self?.collectionView.indexPathOfCellWichInTheCenter()}
    }
    
    override func binding() {
        super.binding()
        viewModel.bindWIthActionButtons(editCardEvent: editCardButton.rx.tap,
                                        moveCardToEvent: moveCardToButton.rx.tap,
                                        copyCardToEvent: copyCardToButton.rx.tap)
    }
    
    override func setupView() {
        super.setupView()
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
    }
    
    override func localizable() {
        super.localizable()
        editCardButton.titleLabel.text = "Edit card"
        moveCardToButton.titleLabel.text = "Move card to"
        copyCardToButton.titleLabel.text = "Copy card to"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDisappeared()
    }
}

extension CardSlideShowViewController: ActionButtonDataSource {
    func getActionButtons() -> [JJActionItem] {
        return [editCardButton, moveCardToButton, copyCardToButton]
    }
}
