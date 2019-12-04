//
//  CardInfoCell.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 03.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class CardInfoCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withTranslateCard card: TranslateCard) {
        let text = "source text: \(card.sourcePhrase)\n" + "target text: \(card.targetPhrase)"
        textLabel?.text = text
    }
    
    fileprivate func loadView() {
        textLabel?.numberOfLines = 0
    }
}
