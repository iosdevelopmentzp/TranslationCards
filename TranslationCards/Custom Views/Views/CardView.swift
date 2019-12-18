//
//  CardView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 17.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CardView: UIView {
    let speakData = BehaviorRelay<SpeechData?>.init(value: nil)
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate(set) var faceSideView = CardSideView()
    fileprivate(set) var backSideView = BackCardSideView()
    fileprivate let tapGesture = UITapGestureRecognizer()
    
    fileprivate let flipFromLeftOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    fileprivate let flipFromRightOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
    
    fileprivate var showedFace: Bool = false {
        didSet {
            if showedFace { faceSideView.addGestureRecognizer(tapGesture)
            } else { backSideView.addGestureRecognizer(tapGesture) }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithCard(_ card: TranslateCard, isShowFace: Bool = true) {
        faceSideView.configure(withCard: card)
        backSideView.configure(withCard: card)
        showFaceSide(isShowFace: isShowFace, withAnimation: false)
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        addSubview(backSideView)
        addSubview(faceSideView)
        [backSideView, faceSideView].forEach {
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    fileprivate func setupView() {
        showedFace = true
    }
    
    fileprivate func binding() {
        tapGesture
            .rx
            .event
            .subscribe(onNext: { [weak self] (_) in
                self?.switchSide(withAnimation: true) })
            .disposed(by: disposeBag)
        
        Observable.merge(faceSideView.speakData.asObservable(), backSideView.speakData.asObservable())
            .compactMap{ $0 }
            .subscribe(onNext: { [weak self] (dataSpeak) in
                self?.speakData.accept(dataSpeak)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func showFaceSide(isShowFace: Bool, withAnimation: Bool) {
        guard isShowFace != showedFace else {
            return
        }
        
        switchSide(withAnimation: withAnimation)
    }
    
    fileprivate func switchSide(withAnimation: Bool) {
        let currentFaceSide = showedFace ? faceSideView : backSideView
        let nextSide = currentFaceSide == backSideView ? faceSideView : backSideView
        
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
