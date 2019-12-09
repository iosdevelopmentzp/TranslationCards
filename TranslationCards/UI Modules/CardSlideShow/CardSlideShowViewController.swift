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

final class CardSlideShowViewController: ViewController<CardSlideShowRouter, CardSlideShowViewModel> {
    
    fileprivate lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    fileprivate let flowLayout = CardSlideShowFlowLayout()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func binding() {
        super.binding()
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.typeName)
        
        disposeBag.insert([
            viewModel.cards.bind(to: collectionView.rx.items(cellIdentifier: CardCell.typeName, cellType: CardCell.self)) { [weak self] row,card,cell in
                guard let self = self else { return }
                cell.configure(withCard: card)
                cell
                    .speakData
                    .skip(1)
                    .compactMap{ $0 }
                    .bind(to: self.viewModel.cellSpeechData)
                    .disposed(by: cell.rx.reuseBag)
            }
        ])
    }
    
    override func setupView() {
        super.setupView()
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDisappeared()
    }
    
}