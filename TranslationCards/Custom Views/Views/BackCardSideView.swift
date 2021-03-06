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

    private let topContainerView = UIView()
    private let topImageView = UIImageView()
    private let topTextLabel = UILabel()
    private let topSpeakButton = UIButton(type: .custom)
    
    private let bottomContainerView = UIView()
    private let bottomImageView = UIImageView()
    private let bottomTextLabel = UILabel()
    private let bottomSpeakButton = UIButton(type: .custom)
    
    private let stackView = UIStackView()
    private let separator = UIView()
    
    private let disposeBag = DisposeBag()
    private let cornerRadius: CGFloat = 10.0
    private var topLanguage: BehaviorRelay<Language?> = .init(value: nil)
    private var bottomLanguage: BehaviorRelay<Language?> = .init(value: nil)
    
    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
    
    func configure(withCard card: TranslateCard, withReverse: Bool) {
        
        let topLanguage = withReverse ? card.language.value.targetLanguage : card.language.value.sourceLanguage
        let topPhrase = withReverse ? card.targetPhrase.value : card.sourcePhrase.value
        
        let bottomLanguage = !withReverse ? card.language.value.targetLanguage : card.language.value.sourceLanguage
        let bottomPhrase = !withReverse ? card.targetPhrase.value : card.sourcePhrase.value
        
        topImageView.image = topLanguage.flagIcon
        topTextLabel.text = topPhrase
        self.topLanguage.accept(topLanguage)
       
        bottomImageView.image = bottomLanguage.flagIcon
        bottomTextLabel.text = bottomPhrase
        self.bottomLanguage.accept(bottomLanguage)
        
        gradientLayer?.removeFromSuperlayer()
        let topColor = topLanguage.associativeColor
        let bottomColor = bottomLanguage.associativeColor
        gradientLayer = setGradient(colorTop: topColor, colorBottom: bottomColor)
    }
    
    // MARK: - Private
    private func setupConstraints() {
        
        let padding = 8.0
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(topContainerView)
        stackView.addArrangedSubview(separator)
        stackView.addArrangedSubview(bottomContainerView)
        
        separator.snp.makeConstraints {
            $0.height.equalTo(2.0)
        }
        
        topContainerView.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.height.equalTo(self.bottomContainerView)
        }
        
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
        topImageContainer.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.left.equalToSuperview().offset(padding)
            $0.bottom.equalTo(self.topSpeakButton.snp.top).offset(-padding)
            $0.width.height.equalTo(44.0)
        }
        
        bottomImageContainer.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(padding)
            $0.width.height.equalTo(44.0)
        }
        
        let buttonSize = 20.0
        topSpeakButton.snp.makeConstraints {
            $0.width.height.equalTo(buttonSize)
            $0.centerX.equalTo(topImageContainer)
            $0.bottom.equalToSuperview().offset(-padding)
        }
        
        bottomSpeakButton.snp.makeConstraints {
            $0.width.height.equalTo(buttonSize)
            $0.top.equalTo(bottomImageContainer.snp.bottom).offset(padding)
            $0.centerX.equalTo(bottomImageContainer)
        }
           
        topTextLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().offset(padding)
            $0.right.equalToSuperview().offset(-padding)
            $0.bottom.equalToSuperview().inset(padding)
            $0.left.equalTo(topImageContainer.snp.right).offset(padding)
        }
        
        bottomTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().offset(-padding)
            $0.bottom.lessThanOrEqualToSuperview().inset(padding)
            $0.left.equalTo(bottomImageContainer.snp.right).offset(padding)
        }
    }
    
    private func setupView() {
        setShadow(withColor: .white,
                  opacity: 0.4,
                  radius: 5.0,
                  offset: .init(width: 2.0, height: 2.0))
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        topImageView.contentMode = .scaleAspectFit
        bottomImageView.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
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
        
        separator.backgroundColor = .white
    }
    
    private func bind() {
        topLanguage
            .compactMap{ $0?.flagIcon}
            .bind(to: topImageView.rx.image)
            .disposed(by: disposeBag)
        
        bottomLanguage
            .compactMap{ $0?.flagIcon}
            .bind(to: bottomImageView.rx.image)
            .disposed(by: disposeBag)
        
        topSpeakButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                guard let text = self?.topTextLabel.text,
                    let language = self?.topLanguage.value else {
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
                    let language = self?.bottomLanguage.value else {
                        self?.speakData.accept(nil)
                        return
                }
                self?.speakData.accept((text, language))
            })
            .disposed(by: disposeBag)
    }
}
