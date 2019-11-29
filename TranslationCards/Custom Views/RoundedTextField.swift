//
//  RoundedTextField.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class RoundedTextField: UITextField {
    
    // MARK: - Public
    public var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    public var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    public var placeholderText: String? {
        didSet {
            guard let text = placeholderText else {
                attributedPlaceholder = nil
                return }
            attributedPlaceholder = .placeholderLight(withText: text)
        }
    }
    
    public var textInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    
    // MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect.init(origin: bounds.origin, size: bounds.size).inset(by: textInset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRect.init(origin: bounds.origin, size: bounds.size).inset(by: textInset)
    }
    
    // MARK: - Private
    func setupView() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        font = .robotoRegular()
        textColor = .defaultTextColor
    }
}
