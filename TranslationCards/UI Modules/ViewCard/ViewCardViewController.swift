//
//  ViewCardViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import JJFloatingActionButton

final class ViewCardViewController: ViewController<ViewCardRouter, ViewCardViewModel> {
    private let cardView = CardView()
    private var editButton = JJActionItem.initWith(imageType: .edit)
    private var moveCardToButton = JJActionItem.initWith(imageType: .move)
    private var copyCardToButton = JJActionItem.initWith(imageType: .copy)
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopSpeach()
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
        viewModel.bind(editEvent: editButton.rx.tap,
                       moveCardToEvent: moveCardToButton.rx.tap,
                       copyCardToEvent: copyCardToButton.rx.tap)
        viewModel.bind(speakData: cardView.speakData)
        
        viewModel.card.subscribe(onNext: { [weak self] (card) in
            self?.cardView.configureWithCard(card)
        })
        .disposed(by: disposeBag)
    }
    
    override func localize() {
        super.localize()
        editButton.titleLabel.text =  "Edit card"
        moveCardToButton.titleLabel.text = "Move card to"
        copyCardToButton.titleLabel.text = "Copy card to"
        viewModel
            .title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}

extension ViewCardViewController: ActionButtonsDataSource {
    func getActionButtons() -> [JJActionItem] {
        return [editButton, moveCardToButton, copyCardToButton]
    }
}
