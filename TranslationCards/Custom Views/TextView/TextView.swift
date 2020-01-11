//
//  TextView.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 02.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class TextView: UITextView {
    
    fileprivate let disposeBag = DisposeBag()

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        startAutoResizeHeightBinding()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateHeigth()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    fileprivate func startAutoResizeHeightBinding() {
        rx.text.subscribe(onNext: { [weak self] (_) in
            self?.updateHeigth()
        })
        .disposed(by: disposeBag)
    }
    
    fileprivate func updateHeigth() {
        guard !translatesAutoresizingMaskIntoConstraints else { return }
        
        let newHeight = contentSize.height * 1.15
        
        guard let heightConstrint = getHeightLayoutConstraint() else {
            snp.makeConstraints {
                $0.height.equalTo(newHeight).priority(900)
            }
            layoutIfNeeded()
            return
        }
        guard heightConstrint.constant != newHeight else { return }
        heightConstrint.constant = newHeight
        layoutIfNeeded()
    }
}
