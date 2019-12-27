//
//  CardCell.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CardCell: UICollectionViewCell {
    
    let speakData = BehaviorRelay<SpeechData?>.init(value: nil)
    
    fileprivate let cardView = CardView()
    fileprivate let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withCard card: TranslateCard, withReverse: Bool = false) {
        cardView.configureWithCard(card, isShowFace: true, withReverse: withReverse)
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    fileprivate func binding() {
        
        Observable<SpeechData?>
            .merge(cardView.faceSideView.speakData.asObservable(), cardView.backSideView.speakData.asObservable())
            .compactMap{$0}
            .subscribe(onNext: { [weak self] (speakData) in
                self?.speakData.accept(speakData)
            })
            .disposed(by: disposeBag)
    }

}
