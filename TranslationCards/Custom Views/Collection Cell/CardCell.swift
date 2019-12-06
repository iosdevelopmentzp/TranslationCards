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
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let faceSide = CardSideView()
    fileprivate let backSide = CardSideView()
    
    fileprivate let flipFromLeftOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    fileprivate let flipFromRightOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
    fileprivate var showedFace: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withCard card: TranslateCard) {
        showFaceSide(isShowFace: true, withAnimation: false)
        debugPrint("showing back - \(showedFace)")
        faceSide.textLabel.text = "\(card.language.sourceLanguage.rawValue):\n\(card.sourcePhrase)"
        
        backSide.textLabel.text = "\(card.language.sourceLanguage.rawValue):\n\(card.sourcePhrase)\n\n\n\(card.language.targetLanguage.rawValue):\n\(card.targetPhrase)"
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        backSide.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backSide)
        backSide.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 30, left: 30, bottom: 30, right: 30))
        }
        
        contentView.addSubview(faceSide)
        faceSide.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 30, left: 30, bottom: 30, right: 30))
        }
        
    }
    
    fileprivate func setupView() {
        faceSide.backgroundColor = .accentColor
        backSide.backgroundColor = .red
        backgroundColor = .clear
    }
    
    fileprivate func binding() {
        
        Observable.merge(faceSide.rx.tapped.asObservable(), backSide.rx.tapped.asObservable())
            .subscribe { [weak self] (gesture) in
                self?.switchSide(withAnimation: true) }
            .disposed(by: disposeBag)
    }
    
    fileprivate func showFaceSide(isShowFace: Bool, withAnimation: Bool) {
        guard isShowFace != showedFace else {
            return
        }
        
        switchSide(withAnimation: withAnimation)
    }
    
    fileprivate func switchSide(withAnimation: Bool) {
        let currentFaceSide = showedFace ? faceSide : backSide
        let nextSide = currentFaceSide == backSide ? faceSide : backSide
        
        if withAnimation {
            let options = showedFace ? flipFromLeftOptions : flipFromRightOptions
            UIView.transition(from: currentFaceSide,
                              to: nextSide,
                              duration: 0.3,
                              options: options,
                              completion: nil)
        } else {
            currentFaceSide.isHidden = true
            nextSide.isHidden = false
        }
       
        self.showedFace = !self.showedFace
    }
}
