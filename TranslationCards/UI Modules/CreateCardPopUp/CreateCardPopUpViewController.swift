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
    private let createTranslateCardView = CreateTranslateCardView()
    
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
        view.backgroundColor = .clear
    }
    
    override func binding() {
        super.binding()
        let input = viewModel.input
        let output = viewModel.output
        let cardView = createTranslateCardView
        
        output
            .card
            .bind(to: cardView.currentCard)
            .disposed(by: disposeBag)
        
        output
            .isInputCorrect
            .map{ $0 ? UIColor.validateAccentColor : UIColor.notValidateButton}
            .bind(to: cardView.saveButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        output
            .isInputCorrect
            .bind(to: cardView.saveButton.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        output
            .mode
            .map{ $0 == .create }
            .bind(to: cardView.removeButton.rx.isHidden)
            .disposed(by: disposeBag)

        cardView
            .translateRealtimeButton
            .rx.tap
            .bind(to: input.translateButtonTap)
            .disposed(by: disposeBag)
        
        cardView
            .sourceTextField
            .rx.text
            .unwrap()
            .bind(to: input.sourcePhraseText)
            .disposed(by: disposeBag)
        
        cardView
            .targetTextField
            .rx.text
            .unwrap()
            .bind(to: input.targetPhraseText)
            .disposed(by: disposeBag)
        
        cardView
            .cancelButton
            .rx.tap
            .bind(to: input.cancelButtonTap)
            .disposed(by: disposeBag)
        
        cardView
            .saveButton
            .rx.tap
            .bind(to: input.saveButtonTap)
            .disposed(by: disposeBag)
        
        cardView
            .removeButton
            .rx.tap
            .bind(to: input.removeButtonTap)
            .disposed(by: disposeBag)
        
        cardView
            .targetSelectLanguageButton
            .rx.tap
            .bind(to: input.targetLanguageTap)
            .disposed(by: disposeBag)
    
        view.rx
            .addTapGestureToHideKeyboard()
            .disposed(by: disposeBag)
    }
}

extension CreateCardPopUpViewController: TransitionAnimationMaker {
    
    func startAnimationBeforeDisappear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType) {
        
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
    
    func startAnimationBeforeAppear(withDelay delay: TimeInterval, duration: TimeInterval, secondViewController: UIViewController?, containerView: UIView, transitionType: ViewControllerTransitionType) {
        
        let blurView = secondViewController?.appendBlurEffect(style: .dark)
        blurView?.alpha = 0.0
        UIView.animate(withDuration: duration * 0.3, delay: delay, animations: {
            blurView?.alpha = 1.0
        })
        containerView.addSubview(view)
        view.layoutIfNeeded()
        
        let screenSize = containerView.bounds.size
        
        // Text fields
        let sourceColor = createTranslateCardView.sourceTextField.textColor
        let targetColor = createTranslateCardView.targetTextField.textColor
        createTranslateCardView.sourceTextField.textColor = .clear
        createTranslateCardView.targetTextField.textColor = .clear
        Timer.scheduledTimer(withTimeInterval: duration * 0.5, repeats: false) { [weak self] (_) in
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.createTranslateCardView.sourceTextField.textColor = sourceColor
                self?.createTranslateCardView.targetTextField.textColor = targetColor
            }
        }
        
        let verticalAnimation1 = CABasicAnimation.animation(withKeyType: .translationY,
                                                            duration: duration * 0.5,
                                                            fromValue: screenSize.height,
                                                            toValue: 0)
        createTranslateCardView.sourceTextField.layer.add(verticalAnimation1, forKey: "translationYTextFieldSource")
        
        let verticalAnimation2 = CABasicAnimation.animation(withKeyType: .translationY,
                                                            duration: verticalAnimation1.duration * 1.2,
                                                            fromValue: screenSize.height,
                                                            toValue: 0)
        createTranslateCardView.targetTextField.layer.add(verticalAnimation2, forKey: "translationYTextFieldTarget")
        createTranslateCardView.translateRealtimeButton.layer.add(verticalAnimation2, forKey: "translationYTranslateButton")

        // Text labels
        let labelShiftX = max(createTranslateCardView.targetHeaderLabel.bounds.width, createTranslateCardView.sourceHeaderLabel.bounds.width)
        [createTranslateCardView.targetHeaderLabel, createTranslateCardView.sourceHeaderLabel].forEach {
            $0.transform = .init(translationX: -labelShiftX, y: 0)
            $0.alpha = 0
        }
        UIView.animate(withDuration: duration) { [weak self] in
            [self?.createTranslateCardView.targetHeaderLabel, self?.createTranslateCardView.sourceHeaderLabel].forEach {
                $0?.transform = CGAffineTransform.identity
                $0?.alpha = 1.0
            }
        }
        
        // language buttons
        let buttonShiftX = max(createTranslateCardView.targetSelectLanguageButton.bounds.width, createTranslateCardView.sourceSelectLanguageButton.bounds.width)
        [createTranslateCardView.targetSelectLanguageButton, createTranslateCardView.sourceSelectLanguageButton].forEach {
            $0.transform = .init(translationX: buttonShiftX, y: 0)
            $0.alpha = 0.0
        }
        UIView.animate(withDuration: duration) { [weak self] in
            [self?.createTranslateCardView.targetSelectLanguageButton, self?.createTranslateCardView.sourceSelectLanguageButton].forEach {
                $0?.transform = CGAffineTransform.identity
                $0?.alpha = 1.0
            }
        }
        
        // cancel, save buttons
        let buttons = [createTranslateCardView.cancelButton, createTranslateCardView.saveButton, createTranslateCardView.removeButton]
        buttons.forEach {
            $0.alpha = 0.0
        }
        
        UIView.animate(withDuration: duration / 2, delay: duration / 2, animations: {
            buttons.forEach {
                $0.alpha = 1.0
            }
        })
    }
    
    func supportedTransitionTypes() -> [ViewControllerTransitionType] {
        return [.present, .dismiss]
    }
}
