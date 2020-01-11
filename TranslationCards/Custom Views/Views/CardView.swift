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
    
    private let disposeBag = DisposeBag()
    private(set) var faceSideView = CardSideView()
    private(set) var backSideView = BackCardSideView()
    private let tapGesture = UITapGestureRecognizer()
    
    private let flipFromLeftOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    private let flipFromRightOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
    
    private var showedFace: Bool = false {
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
    
    func configureWithCard(_ card: TranslateCard, isShowFace: Bool = true, withReverse: Bool = false) {
        faceSideView.configure(withCard: card, withReverse: withReverse)
        backSideView.configure(withCard: card, withReverse: withReverse)
        showFaceSide(isShowFace: isShowFace, withAnimation: false)
    }
    
    // MARK: - Private
    private func setupConstraints() {
        addSubview(backSideView)
        addSubview(faceSideView)
        [backSideView, faceSideView].forEach {
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    private func setupView() {
        showedFace = true
    }
    
    private func binding() {
        tapGesture
            .rx
            .event
            .subscribe(onNext: { [weak self] (_) in
                self?.switchSide(withAnimation: true) })
            .disposed(by: disposeBag)
        
        Observable.merge(faceSideView.speakData.asObservable(), backSideView.speakData.asObservable())
            .unwrap()
            .subscribe(onNext: { [weak self] (dataSpeak) in
                self?.speakData.accept(dataSpeak)
            })
            .disposed(by: disposeBag)
    }
    
    private func showFaceSide(isShowFace: Bool, withAnimation: Bool) {
        guard isShowFace != showedFace else {
            return
        }
        
        switchSide(withAnimation: withAnimation)
    }
    
    private func switchSide(withAnimation: Bool) {
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
