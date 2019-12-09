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
    fileprivate let backSide = BackCardSideView()
    
    fileprivate let tapGesture = UITapGestureRecognizer()
    fileprivate let dragGesture = UIPanGestureRecognizer()
    
    fileprivate let flipFromLeftOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    fileprivate let flipFromRightOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
    fileprivate var showedFace: Bool = false {
        didSet {
            if showedFace {
                faceSide.addGestureRecognizer(tapGesture)
            } else {
                backSide.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupGesture()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withCard card: TranslateCard) {
        showFaceSide(isShowFace: true, withAnimation: false)
        faceSide.configure(withCard: card)
        backSide.configure(withCard: card)
    }
    
    // MARK: - Private
    fileprivate func setupGesture() {
        faceSide.addGestureRecognizer(tapGesture)
        faceSide.addGestureRecognizer(dragGesture)
    }
    
    fileprivate func setupConstraints() {
        backSide.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backSide)
        contentView.addSubview(faceSide)
        [backSide, faceSide].forEach {
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.6)
            }
        }
    }
    
    fileprivate func binding() {
        tapGesture
            .rx
            .event
            .subscribe(onNext: { [weak self] (_) in
                self?.switchSide(withAnimation: true) })
            .disposed(by: disposeBag)
        
        dragGesture
            .rx
            .event
            .subscribe(onNext: { /*[weak self]*/ (sender) in
                
                // TODO: - Implement pan gesture later
                
                //guard let self = self else { return }
                /*
                switch sender.state {
                case .changed:
                    let translation = sender.translation(in: self)
                    self.faceSide.center = CGPoint(x: self.faceSide.center.x, y: self.faceSide.center.y + translation.y)
                    sender.setTranslation(CGPoint.zero, in: self)
                case .ended:
                    self.updateConstraints()
                default: break
                }
                */
            })
            .disposed(by: disposeBag)
        
        dragGesture.delegate = self
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

extension CardCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
