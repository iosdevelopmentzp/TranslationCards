//
//  CardSide.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CardSideView: UIView {

    fileprivate let tapGesture = UITapGestureRecognizer()
    fileprivate(set) var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.right.equalToSuperview().inset(8.0)
            $0.top.greaterThanOrEqualTo(self).offset(8.0)
            $0.bottom.lessThanOrEqualTo(self).inset(8.0)
        }
    }
    
    func setupView() {
        setShadow(withColor: .white,
                  opacity: 0.4,
                  radius: 5.0,
                  offset: .init(width: 2.0, height: 2.0))
        layer.cornerRadius = 10.0
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.isUserInteractionEnabled = false
    }
    
    func setupGesture() {
        addGestureRecognizer(tapGesture)
    }
}

extension Reactive where Base: CardSideView {
    var tapped: ControlEvent<UITapGestureRecognizer>  {
        return base.tapGesture.rx.event
    }
}
