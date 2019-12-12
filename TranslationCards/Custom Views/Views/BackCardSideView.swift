//
//  BackCardSideView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 07.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class BackCardSideView: UIView {
    
    var speakData = BehaviorRelay<SpeechData?>.init(value: nil)

    fileprivate let topContainerView = UIView()
    fileprivate let topImageView = UIImageView()
    fileprivate let topTextLabel = UILabel()
    fileprivate let topSpeakButton = UIButton(type: .custom)
    
    fileprivate let bottomContainerView = UIView()
    fileprivate let bottomImageView = UIImageView()
    fileprivate let bottomTextLabel = UILabel()
    fileprivate let bottomSpeakButton = UIButton(type: .custom)
    
    fileprivate let stackView = UIStackView()
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let cornerRadius: CGFloat = 10.0
    fileprivate var topLanguage: Language?
    fileprivate var bottomLanguage: Language?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withCard card: TranslateCard) {
        topImageView.image = card.language.sourceLanguage.flagIcon
        topTextLabel.text = card.sourcePhrase
        topContainerView.backgroundColor  = card.language.sourceLanguage.associativeColor
        topLanguage = card.language.sourceLanguage
       
        bottomImageView.image = card.language.targetLanguage.flagIcon
        bottomTextLabel.text = card.targetPhrase
        bottomContainerView.backgroundColor = card.language.targetLanguage.associativeColor
        bottomLanguage = card.language.targetLanguage
    }
    
    // MARK: - Private
    fileprivate func setupConstraints() {
        
        let padding = 8.0
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(topContainerView)
        stackView.addArrangedSubview(bottomContainerView)
        
        let topImageContainer = UIView()
        let bottomImageContainer = UIView()
        topImageContainer.addSubview(topImageView)
        bottomImageContainer.addSubview(bottomImageView)
        topContainerView.addSubview(topImageContainer)
        topContainerView.addSubview(topTextLabel)
        topContainerView.addSubview(topSpeakButton)
        bottomContainerView.addSubview(bottomImageContainer)
        bottomContainerView.addSubview(bottomTextLabel)
        bottomContainerView.addSubview(bottomSpeakButton)
        
        [topImageView, bottomImageView].forEach {
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        [topImageContainer, bottomImageContainer].forEach {
            $0.snp.makeConstraints {
                $0.top.left.equalToSuperview().offset(padding)
                $0.width.height.equalTo(44.0)
            }
        }
        
        [topSpeakButton, bottomSpeakButton].forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(20.0)
                $0.right.bottom.equalToSuperview().inset(padding)
            }
        }
           
        topTextLabel.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
            $0.bottom.lessThanOrEqualTo(self.topSpeakButton.snp.top)
            $0.left.equalTo(topImageContainer.snp.right).offset(padding)
        }
        
        bottomTextLabel.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
            $0.bottom.lessThanOrEqualTo(self.bottomSpeakButton.snp.top)
            $0.left.equalTo(bottomImageContainer.snp.right).offset(padding)
        }
    }
    
    fileprivate func setupView() {
        setShadow(withColor: .white,
                  opacity: 0.4,
                  radius: 5.0,
                  offset: .init(width: 2.0, height: 2.0))
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        topImageView.contentMode = .scaleAspectFit
        bottomImageView.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        let speakerImage = UIImage.image(withType: .speaker, renderringMode: .alwaysTemplate)
        [topSpeakButton, bottomSpeakButton].forEach {
            $0.setBackgroundImage(speakerImage, for: .normal)
            $0.tintColor = .white
        }
        
        [topTextLabel, bottomTextLabel].forEach {
            $0.numberOfLines = 0
            $0.textColor = .white
            $0.font = .font(type: .roboto, weight: .bold, size: 20)
        }
    }
    
    fileprivate func bind() {
        topSpeakButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                guard let text = self?.topTextLabel.text,
                    let language = self?.topLanguage else {
                        self?.speakData.accept(nil)
                        return
                }
                self?.speakData.accept((text, language))
            })
            .disposed(by: disposeBag)
        
        bottomSpeakButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                guard let text = self?.bottomTextLabel.text,
                    let language = self?.bottomLanguage else {
                        self?.speakData.accept(nil)
                        return
                }
                self?.speakData.accept((text, language))
            })
            .disposed(by: disposeBag)
    }
}
