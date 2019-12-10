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
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.95)
        }
    }
    
    override func setupView() {
        super.setupView()
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .clear
    }
    
    override func binding() {
        super.binding()
        viewModel.bind(withNewPhrase: createTranslateCardView.sourceTextField.rx.text.orEmpty,
                       translation: createTranslateCardView.targetTextField.rx.text.orEmpty,
                       saveButtonPressed: createTranslateCardView.saveButton.rx.tap,
                       cancelButtonPressed: createTranslateCardView.cancelButton.rx.tap)

        tapGesture
            .rx
            .event
            .subscribe(onNext: { [weak self] (gesture) in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
    override func localizable() {
        super.localizable()
        createTranslateCardView.sourceHeaderLabel.attributedText = .placeholderLight(withText: "New phrase")
         createTranslateCardView.targetHeaderLabel.attributedText = .placeholderLight(withText: "Translation")
        createTranslateCardView.sourceTextField.text = ""
        createTranslateCardView.targetTextField.text = ""
        createTranslateCardView.saveButton.setAttributedTitle(.defaultText(withText: "Save", size: 20.0), for: .normal)
        createTranslateCardView.cancelButton.setAttributedTitle(.defaultText(withText: "Cancel"), for: .normal)
    }
}

extension CreateCardPopUpViewController: TransitionAnimatorMaker {
    
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: NavigationOperationType) {
        
        let blurEffectView = secondViewController?.getBlurEffect()
        
        UIView.animate(withDuration: duration * 0.3,
                       delay: delay,
                       animations: {
                        blurEffectView?.alpha = 0.0
        }, completion: {
            [weak self] (_) in
            blurEffectView?.removeFromSuperview()
            self?.createTranslateCardView.subviews.forEach {
                $0.alpha = 0.0
            }
        })
        
        let xAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xAnimation.toValue = 0.3
        xAnimation.duration = duration / 2
        xAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        xAnimation.fillMode = CAMediaTimingFillMode.forwards
        xAnimation.isRemovedOnCompletion = false
        
        let yAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yAnimation.toValue = 0.3
        yAnimation.duration = duration / 2
        yAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        yAnimation.fillMode = CAMediaTimingFillMode.forwards
        yAnimation.isRemovedOnCompletion = false
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.toValue = 0.0
        alphaAnimation.duration = duration / 2
        alphaAnimation.fillMode = CAMediaTimingFillMode.forwards
        alphaAnimation.isRemovedOnCompletion = false
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = duration / 2
        groupAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = .forwards
        groupAnimation.animations = [xAnimation, yAnimation, alphaAnimation]
        createTranslateCardView.layer.add(groupAnimation, forKey: "scale")
        
        Timer.scheduledTimer(withTimeInterval: duration / 2,
                             repeats: false) { [weak self] (_) in
                                self?.createTranslateCardView.removeFromSuperview()
        }
    }
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: NavigationOperationType) {
        createTranslateCardView.transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
        createTranslateCardView.alpha = 0.0
        let blurView = secondViewController?.appendBlurEffect(style: .light)
        blurView?.alpha = 0.0
        
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
                        self?.createTranslateCardView.alpha = 1.0
                        blurView?.alpha = 1.0
        }) { (_) in }
    }
    
    func typesWhichSupportedAnimation() -> [NavigationOperationType] {
        return [.present, .dismiss]
    }
}
