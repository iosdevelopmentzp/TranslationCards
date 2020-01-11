//
//  WritePhrase.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import RxKeyboard

final class WritePhraseCell: UICollectionViewCell {
    
    // MARK: - Private propeties
    private let writeView = WritePhraseView()
    private let tapGesture = UITapGestureRecognizer()
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithCard(_ card: TranslateCard) {
        writeView.configureWithCard(card)
    }
    
    //MARK: - Private
    private func setupConstraints() {
        addSubview(writeView)
        writeView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    private func setupView() {
        addGestureRecognizer(tapGesture)
    }
    
    private func binding() {
        RxKeyboard
            .instance
            .visibleHeight
            .asObservable()
            .skip(1)
            .bind(to: writeView.bottomTextFieldOffset)
            .disposed(by: disposeBag)
        
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] (_) in
                self?.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}
