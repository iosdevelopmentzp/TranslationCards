//
//  LanguageChoiceViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 12.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class LanguageChoiceViewController: ViewController<LanguageChoiceRouter, LanguageChoiceViewModel> {
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
        
        viewModel.bind(choiseLanguageButtonEvent: choiseLanguageButton.rx.tap, nextButtonEvent: nextButton.rx.tap)
        
        viewModel
            .selectedLanguage
            .map{ $0 != nil}
            .subscribe(onNext: { [weak self] (isValidate) in
                self?.nextButton.backgroundColor = isValidate ? UIColor.accentColor : UIColor.notValidateButton
                self?.nextButton.isUserInteractionEnabled = isValidate
            })
            .disposed(by: disposeBag)
        
        viewModel
            .languageImage
            .bind(to: choiseLanguageButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel
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
