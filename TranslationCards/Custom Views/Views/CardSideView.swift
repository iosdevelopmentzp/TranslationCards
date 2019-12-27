//
//  CardSide.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 04.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class CardSideView: UIView {

    var speakData = BehaviorRelay<SpeechData?>.init(value: nil)
    
    fileprivate let speakButton = UIButton(type: .custom)
    fileprivate let textLabel = UILabel()
    fileprivate let iconImageView = UIImageView()
    
    fileprivate var language: BehaviorRelay<Language?> = .init(value: nil)
    fileprivate var gradientLayer: CAGradientLayer?
    fileprivate let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withCard card: TranslateCard, withReverse: Bool = false) {
        let currentLanguage = withReverse ? card.language.targetLanguage : card.language.sourceLanguage
        let phrase = withReverse ? card.targetPhrase : card.sourcePhrase
        textLabel.text = "\(phrase)"
        language.accept(currentLanguage)
        
        gradientLayer?.removeFromSuperlayer()
        let topColor = currentLanguage.associativeColor
        if let lighterColor = topColor.lighter() {
            gradientLayer = setGradient(colorTop: lighterColor,
                                        colorBottom: topColor)
        }
    }
    
    // MARK: - Private
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
    
    fileprivate func setupConstraints() {
        let  containerView = UIView()
        containerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { $0.edges.equalToSuperview()}
        addSubview(containerView)
        let padding: CGFloat = 16.0
        containerView.snp.makeConstraints {
            $0.width.height.equalTo(44.0)
            $0.top.left.equalToSuperview().offset(padding)
        }
        
        addSubview(speakButton)
        speakButton.snp.makeConstraints {
            $0.width.height.equalTo(20.0)
            $0.right.bottom.equalToSuperview().inset(padding)
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.right.equalToSuperview().inset(8.0)
            $0.top.greaterThanOrEqualTo(self.iconImageView.snp.bottom).offset(4.0)
            $0.bottom.lessThanOrEqualTo(self.speakButton.snp.top).inset(8.0)
        }
    }
    
    fileprivate func setupView() {
        setShadow(withColor: .white,
                  opacity: 0.4,
                  radius: 5.0,
                  offset: .init(width: 2.0, height: 2.0))
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.isUserInteractionEnabled = false
        textLabel.textColor = .white
        textLabel.font = .font(type: .roboto, weight: .bold, size: 20)
        
        iconImageView.contentMode = .scaleAspectFit
        
        let image = UIImage.image(withType: .speaker, renderringMode: .alwaysTemplate)
        speakButton.setBackgroundImage(image, for: .normal)
        speakButton.tintColor = .white
    }
    
    fileprivate func bind() {
        language
            .compactMap{ $0?.flagIcon }
            .bind(to: iconImageView.rx.image)
            .disposed(by: disposeBag)
        
        speakButton
            .rx
            .tap
            .map { [weak self] (_) -> SpeechData? in
                guard let language = self?.language,
                    let text = self?.textLabel.text else {
                    return nil
                }
                return  (text: text, language: language.value) }
            .subscribe(onNext: { [weak self] (inputData) in
                self?.speakData.accept(inputData)
            })
            .disposed(by: disposeBag)
    }
}
