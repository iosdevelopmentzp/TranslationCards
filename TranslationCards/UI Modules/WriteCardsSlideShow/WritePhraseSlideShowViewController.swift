//
//  WriteCardsSlideShowViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import JJFloatingActionButton

final class WritePhraseSlideShowViewController: ViewController<WritePhraseSlideShowRouter, WritePhraseSlideShowViewModel> {
    fileprivate lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    fileprivate let flowLayout = AnimatedCollectionViewLayout()
    fileprivate let animator = PageAttributesAnimator(scaleRate: 0.2)
    fileprivate let editCardButton = JJActionItem.initWith(imageType: .edit)
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        collectionView.register(WritePhraseCell.self, forCellWithReuseIdentifier: WritePhraseCell.typeName)
        
        viewModel.cardsDataSource.bind(to: collectionView.rx.items(cellIdentifier: WritePhraseCell.typeName, cellType: WritePhraseCell.self)) { row, card, cell in
            cell.configureWithCard(card)
        }
        .disposed(by: disposeBag)
    }
    
    override func setupView() {
        super.setupView()
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        flowLayout.animator = animator
        flowLayout.scrollDirection = .horizontal
    }
    
    override func binding() {
        super.binding()
        viewModel.getSelectedCellIndexPath = { [weak self] in return self?.collectionView.indexPathOfCellWichInTheCenter()}
        
        viewModel.bindWIthActionButtons(editCardEvent: editCardButton.rx.tap)
    }
    
    override func localize() {
        super.localize()
        editCardButton.titleLabel.text = "Edit card"
        title = "Write Phrase"
    }
}

extension WritePhraseSlideShowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension WritePhraseSlideShowViewController: ActionButtonDataSource {
    func getActionButtons() -> [JJActionItem] {
        return [editCardButton]
    }
}
