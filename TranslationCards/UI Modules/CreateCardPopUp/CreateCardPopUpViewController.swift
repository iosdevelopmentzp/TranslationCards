//
//  CreateCardViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import RxCocoa

final class CreateCardPopUpViewController: ViewController<CreateCardPopUpRouter, CreateCardPopUpViewModel> {
    fileprivate let createTranslateCardView = CreateTranslateCardView()
    fileprivate let tapGesture = UITapGestureRecognizer()
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(createTranslateCardView)
        createTranslateCardView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.95)
        }
    }
    
    override func setupView() {
        super.setupView()
        view.addGestureRecognizer(tapGesture)
    }
    
    override func binding() {
        super.binding()
        viewModel.bind(withNewPhrase: createTranslateCardView.sourceTextField.rx.text.orEmpty,
                       translation: createTranslateCardView.targetTextField.rx.text.orEmpty,
                       saveButtonPressed: createTranslateCardView.saveButton.rx.tap)
        viewModel.bindTapGesture(event: tapGesture.rx.event)
    }
    
    override func localizable() {
        super.localizable()
        createTranslateCardView.sourceHeaderLabel.attributedText = .placeholderDark(withText: "Set new phrase")
         createTranslateCardView.targetHeaderLabel.attributedText = .placeholderDark(withText: "Set translation of new phrase")
        createTranslateCardView.sourceTextField.text = ""
        createTranslateCardView.targetTextField.text = ""
        createTranslateCardView.saveButton.setAttributedTitle(.defaultText(withText: "Save new card", size: 20.0), for: .normal)
    }
}

extension CreateCardPopUpViewController: TransitionAnimatorMaker {
    
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: NavigationOperationType) {
        
        UIView.animate(withDuration: duration * 0.3,
                       delay: delay,
                       animations: { [weak self] in
                        self?.view.backgroundColor = .clear
        })
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       animations: { [weak self] in
                        self?.createTranslateCardView.transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
                        self?.createTranslateCardView.alpha = 0.0
        }) { [weak self] (_) in
            self?.view.removeFromSuperview()
        }
    }
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: NavigationOperationType) {
        view.backgroundColor = .clear
        createTranslateCardView.transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
        createTranslateCardView.alpha = 0.0
        
        containerView.addSubview(view)
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseIn,
                       animations: { [weak self] in
                        self?.createTranslateCardView.transform = CGAffineTransform.identity
        }) { (_) in }
        
        UIView.animate(withDuration: duration * 0.3,
                       delay: delay,
                       animations: { [weak self] in
                        self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        self?.createTranslateCardView.alpha = 1.0
        }) { (_) in }
    }
    
    func typesWhichSupportedAnimation() -> [NavigationOperationType] {
        return [.present, .dismiss]
    }
}
