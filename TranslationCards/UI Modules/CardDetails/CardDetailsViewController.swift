//
//  DetailCardViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import JJFloatingActionButton

final class CardDetailsViewController: ViewController<CardDetailsRouter, CardDetailsViewModel> {
    private let cardView = CardView()
    private var editButton = JJActionItem.initWith(imageType: .edit)
    private var moveCardToItem = JJActionItem.initWith(imageType: .move)
    private var copyCardToItem = JJActionItem.initWith(imageType: .copy)
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.input.stopTextPlayback()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let padding: CGFloat = 50.0
        
        view.addSubview(cardView)
        cardView.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.left.equalTo(self.view.safeAreaLayoutGuide).offset(padding)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).inset(padding)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(padding * 1.5)
        }
    }
    
    override func binding() {
        super.binding()
        let input = viewModel.input
        let output = viewModel.output
        
        editButton
            .rx.tap
            .bind(to: input.editCardTap)
            .disposed(by: disposeBag)
        
        moveCardToItem
            .rx.tap
            .bind(to: input.moveCardTap)
            .disposed(by: disposeBag)
        
        copyCardToItem
            .rx.tap
            .bind(to: input.copyCardTap)
            .disposed(by: disposeBag)
        
        cardView
            .speakData
            .bind(to: input.speechData)
            .disposed(by: disposeBag)
        
        output.card.subscribe(onNext: { [weak self] (card) in
            self?.cardView.configureWithCard(card)
        })
        .disposed(by: disposeBag)
    }
    
    override func localize() {
        super.localize()
        editButton.titleLabel.text =  "Edit card"
        moveCardToItem.titleLabel.text = "Move card to"
        copyCardToItem.titleLabel.text = "Copy card to"
        viewModel.output.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
    }
}

extension CardDetailsViewController: ActionButtonsDataSource {
    func getActionButtons() -> [JJActionItem] {
        return [editButton, moveCardToItem, copyCardToItem]
    }
}
