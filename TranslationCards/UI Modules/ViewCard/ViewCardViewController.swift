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
    fileprivate let cardView = CardView()
    fileprivate lazy var editButton = JJActionItem()
    fileprivate lazy var switchLocationCard = JJActionItem()
    
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
    
    override func setupView() {
        super.setupView()
        cardView.configureWithCard(viewModel.card.value)
        
        editButton.imageView.image = .image(withType: .edit, renderringMode: .alwaysTemplate)
        switchLocationCard.imageView.image = .image(withType: .switch, renderringMode: .alwaysTemplate)
    }
    
    override func binding() {
        super.binding()
        viewModel.bind(editEvent: editButton.rx.tap)
        viewModel.bind(switchLocationEvent: switchLocationCard.rx.tap)
    }
    
    override func localizable() {
        super.localizable()
        editButton.titleLabel.text =  "Edit card"
        switchLocationCard.titleLabel.text = viewModel.mode.value == .actual ? "Move to archive" : "Move from archive"
        viewModel
            .title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}

extension ViewCardViewController: ActionButtonDataSource {
    func getActionButtons() -> [JJActionItem] {
        let buttons = viewModel.mode.value == .actual ? [editButton, switchLocationCard] : [switchLocationCard]
        return buttons
    }
}
