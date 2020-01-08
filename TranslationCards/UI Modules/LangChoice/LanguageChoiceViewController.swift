//
//  LanguageChoiceViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 12.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class LanguageChoiceViewController: ViewController<LanguageChoiceRouter, LanguageChoiceViewModel> {
    let label = UILabel()
    let choiseLanguageButton = UIButton(type: .custom)
    let nextButton = RoundedButton()
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(choiseLanguageButton)
        choiseLanguageButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.choiseLanguageButton.snp.bottom).offset(30.0)
            $0.left.equalToSuperview().offset(50.0)
            $0.right.equalToSuperview().inset(50.0)
            $0.height.equalTo(50.0)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.bottom.equalTo(self.choiseLanguageButton.snp.top).offset(-50.0)
            $0.left.equalToSuperview().offset(50.0)
            $0.right.equalToSuperview().inset(50.0)
        }
    }
    
    override func setupView() {
        super.setupView()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .font(type: .roboto, weight: .bold, size: 33.0)
        label.textColor = .white
        choiseLanguageButton.setTitleColor(.innactiveButtonTitleColor, for: .normal)
        choiseLanguageButton.imageView?.contentMode = .scaleAspectFill
        choiseLanguageButton.imageEdgeInsets = .init(top: -10.0, left: -10.0, bottom: -10.0, right: -10.0)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.hidesBackButton = true
    }
    
    override func binding() {
        super.binding()
        
        let input = viewModel.input
        let output = viewModel.output
        
        nextButton.rx
            .tap
            .subscribe(input.nextButtonEvent)
            .disposed(by: disposeBag)
        
        choiseLanguageButton.rx
            .tap
            .subscribe(input.choiceLanguageAction)
            .disposed(by: disposeBag)
        
        let isLanguageSelected = output
            .selectedLanguage
            .map{ $0 != nil }
        
        isLanguageSelected
            .bind(to: nextButton.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        isLanguageSelected
            .map{ $0 ? UIColor.accentColor : UIColor.notValidateButton}
            .subscribe(onNext: { [weak self] (newColor) in
                guard let currentColor = self?.nextButton.backgroundColor,
                    currentColor != newColor else { return }
                UIView.animate(withDuration: 0.3) {
                    self?.nextButton.backgroundColor = newColor
                }})
            .disposed(by: disposeBag)
        
        output
            .languageImage
            .map{ $0?.scaledToSize(.init(width: 30.0, height: 30.0), renderringMode: .alwaysOriginal)}
            .bind(to: nextButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
        
        output
            .languageTitle
            .bind(to: choiseLanguageButton.rx.title())
            .disposed(by: disposeBag)
    }
    
    override func localizable() {
        super.localizable()
        label.text = "Choose your native language"
        nextButton.setTitle("Next", for: .normal)
    }
}
