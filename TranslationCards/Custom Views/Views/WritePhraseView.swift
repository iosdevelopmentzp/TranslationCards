//
//  WritePhraseView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import SnapKit

fileprivate enum TextState {
    case invalidate
    case valide
    case completely
    
    var textColor: UIColor {
        switch self {
        case .invalidate:
            return .red
        case .valide:
            return .orange
        case .completely:
            return .green
        }
    }
}

class WritePhraseView: UIView {
    
    // MARK: - Public
    let bottomTextFieldOffset: BehaviorRelay<CGFloat> = .init(value: 0)
    
    // MARK: - Private
    fileprivate weak var card: TranslateCard?
    fileprivate let headerLabel = UILabel()
    fileprivate let oneMoreWordButton = UIButton()
    fileprivate var bottomTextFieldConstraint: Constraint?
    fileprivate let textView = TextView()
    let textViewHeaderLabel = UILabel()
    fileprivate var currentShownTranslate: String?
    
    // MARK: - Rx
    fileprivate let disposeBag = DisposeBag()
    fileprivate let textState = BehaviorRelay.init(value: TextState.invalidate)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        binding()
        localizable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithCard(_ card: TranslateCard) {
        headerLabel.text = card.sourcePhrase
        textView.text = ""
        bottomTextFieldOffset.accept(0)
        parentViewController?.view.endEditing(true)
        self.card = card
    }
    
    // MARK: - Private methods
    fileprivate func setupConstraints() {
        let padding: CGFloat = 16.0
        addSubview(textView)
        addSubview(headerLabel)
        addSubview(textViewHeaderLabel)
        textView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.right.left.equalToSuperview()
            self.bottomTextFieldConstraint = $0.bottom.equalToSuperview().constraint
            $0.top.lessThanOrEqualTo(self.headerLabel.snp.bottom)
        }
        
        textViewHeaderLabel.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.leading.equalTo(self.textView.snp.leading).offset(padding/2)
            $0.trailing.equalTo(self.textView.snp.trailing).offset(-padding/2)
            $0.bottom.equalTo(self.textView.snp.top).offset(-padding/4)
        }

        headerLabel.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.left.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().inset(padding)
            $0.bottom.lessThanOrEqualTo(self.textView.snp.top)
        }
        
        addSubview(oneMoreWordButton)
        oneMoreWordButton.snp.makeConstraints {
            $0.width.height.equalTo(30.0)
            $0.top.equalToSuperview().offset(padding / 2)
            $0.right.equalToSuperview().inset(padding / 2)
        }
    }
    
    fileprivate func setupView() {
        // self
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        
        // header label
        headerLabel.textAlignment = .center
        headerLabel.textColor = .white
        headerLabel.numberOfLines = 0
        
        // text view
        textView.textColor = .white
        textView.tintColor = .white
        textView.font = .font(type: .roboto, weight: .regular, size: 17.0)
        textView.backgroundColor = .gray
        textView.setBorder(withColor: .white, borderWidth: 1.0, cornerRadius: 5.0)
        textView.autocorrectionType = .no
        
        // oneMoreWordButton
        oneMoreWordButton.setImage(.image(withType: .plus1, renderringMode: .alwaysOriginal), for: .normal)
        
        // textViewHeaderLabel
        textViewHeaderLabel.textColor = .placeholderLightColor
        textViewHeaderLabel.font = .font(type: .roboto, weight: .light, size: 12.0)
    }
    
    fileprivate func binding() {
        bottomTextFieldOffset
            .skip(1)
            .subscribe(onNext: { [weak self] (offset) in
                guard let self = self else { return }
                
                guard
                    let layoutConstraint = self.bottomTextFieldConstraint?.layoutConstraints.first,
                    layoutConstraint.constant != offset else { return }
                
                let bottomOffsetSuperview: CGFloat = offset > 0 ? self.calculateBottomOffsetOnSuperview() : 0.0
                let bottomSafeAreaInset = offset > 0 ? UIWindow.safeAreaBottomHeight : 0.0
                layoutConstraint.constant = -offset + bottomOffsetSuperview + bottomSafeAreaInset
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        textView.rx
            .text
            .compactMap { $0 }
            .map { [weak self] in
                self?.updateHeaderTextIfNeed(potentialTranslateText: $0)
                return self?.checkValidText(correctText: self?.card?.targetPhrase ?? "", checkText: $0) ?? .invalidate }
            .distinctUntilChanged()
            .bind(to: textState)
            .disposed(by: disposeBag)
        
        textState
            .distinctUntilChanged()
            .map { $0.textColor }
            .subscribe(onNext: { [weak self] (textColor) in
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.textView.textColor = textColor
                }
            })
            .disposed(by: disposeBag)
        
        oneMoreWordButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                self?.appendNewWorldIfNeed()
            })
            .disposed(by: disposeBag)
        
        textView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    fileprivate func localizable() {
        textViewHeaderLabel.text = "Try to write a translation"
    }
    
    fileprivate func appendNewWorldIfNeed() {
        guard let card = card else { return }
        var currentOpenWords = (self.currentShownTranslate ?? "").lowercased().words
        let realTranslationsWords = card.targetPhrase.lowercased().words
        
        guard currentOpenWords.count < realTranslationsWords.count, realTranslationsWords.count > 0  else { return }
        let nextIndex = currentOpenWords.count > 0 ? currentOpenWords.count : 0
        let nextWord = realTranslationsWords[nextIndex]
        currentOpenWords.append(nextWord)
        let newTextViewText = currentOpenWords.joined(separator: " ").capitalizingFirstLetter()
        if textView.text != newTextViewText {
            textView.text = newTextViewText
        }
    }
    
    fileprivate func calculateBottomOffsetOnSuperview() -> CGFloat {
        guard let superViewFrame = superview?.frame else { return 0.0 }
        let offset = superViewFrame.height - frame.origin.y - frame.size.height
        return offset >= 0 ? offset : 0.0
    }
    
    fileprivate func updateHeaderTextIfNeed(potentialTranslateText: String) {
        let newAttribute = self.makeAttributeText(sourceText: card?.sourcePhrase ?? "",
                                                  translateText: card?.targetPhrase ?? "",
                                                  potentialTranslate: potentialTranslateText)
        let headerText = headerLabel.text ?? ""
        if newAttribute.string != headerText,  !newAttribute.string.isEmpty {
            UIView.transition(with: headerLabel,
                 duration: 0.25,
                  options: .transitionCrossDissolve,
               animations: { [weak self] in
                   self?.headerLabel.attributedText = newAttribute
            }, completion: nil)
        }
    }
    
    fileprivate func makeAttributeText(sourceText: String, translateText: String, potentialTranslate: String) -> NSAttributedString {
        let divitedTranslate = translateText.lowercased().words
        let divitedPotentialTranslate = potentialTranslate.lowercased().words
        var rightTranslations = Array<String>()
        for (index, currentWorld) in divitedPotentialTranslate.enumerated() {
            guard index < divitedTranslate.count else { break }
            let rightTranslate = String(divitedTranslate[index])
            if rightTranslate != String(currentWorld) {
                break
            } else {
                rightTranslations.append(String(currentWorld))
            }
        }
        
        let finishTranslateText = rightTranslations.joined(separator: " ").capitalizingFirstLetter()
        self.currentShownTranslate = finishTranslateText.isEmpty ? nil : finishTranslateText
        let finishText = finishTranslateText.isEmpty ? sourceText : sourceText + "\n" + finishTranslateText
        let attrStr = NSMutableAttributedString(string: finishText)
        
        let sourceTextRange = (finishText as NSString).range(of: sourceText)
        attrStr.setAttributes(NSAttributedString.writeSlideShowTargetText, range: sourceTextRange)
        let translationTextRange = (finishText as NSString).range(of: finishTranslateText)
        attrStr.setAttributes(NSAttributedString.writeSlideShowTranslateText, range: translationTextRange)
        
        return attrStr
    }
    
    fileprivate func checkValidText(correctText: String, checkText: String) -> TextState{
        
        var newState = TextState.valide
        
        let correctSeparatedWords = correctText.lowercased().words
        let checkSeparatedWords = checkText.lowercased().words
        
        if correctSeparatedWords.count <= 0 {
            newState = .invalidate
        } else if checkSeparatedWords.count > correctSeparatedWords.count {
            newState = .invalidate
        } else if checkSeparatedWords == correctSeparatedWords {
            newState = .completely
        } else {
            checkSeparatedWords.enumerated().forEach { (index, element) in
                let identityCheckWord = correctSeparatedWords[index]
                if index != checkSeparatedWords.lastIndex && identityCheckWord != element {
                    newState = .invalidate
                } else if index == checkSeparatedWords.lastIndex && !identityCheckWord.hasPrefix(element) {
                    newState = .invalidate
                }
            }
        }

        return newState
    }
}

extension WritePhraseView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return text.count <= 1 && range.length <= 1 && text != "\n"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textViewHeaderLabel.alpha != 0.0 else { return }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.textViewHeaderLabel.alpha = 0.0
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textViewHeaderLabel.alpha != 1.0 && textView.text.isEmpty else { return }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.textViewHeaderLabel.alpha = 1.0
        }
    }
}