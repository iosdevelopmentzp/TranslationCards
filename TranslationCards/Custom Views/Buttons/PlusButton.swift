//
//  PlusButton.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

class PlusButton: UIButton {
    
    private struct Constants {
        static let scalePlus: CGFloat = 0.7
        static let plusLineWidthScale: CGFloat = 0.05
    }

    override var bounds: CGRect {
        didSet {
            setNeedsDisplay() }
    }

    override var tintColor: UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.validateAccentColor.setFill()
        path.fill()
        
        let plusWidth = min(rect.width, rect.height) * Constants.scalePlus
        let halfPlusWidth = plusWidth / 2
        let lineWidth = min(rect.width, rect.height) * Constants.plusLineWidthScale
        let halfWidth = rect.width / 2
        let halfHeight = rect.height / 2

        let plusPath = UIBezierPath()
        plusPath.lineWidth = lineWidth
        plusPath.move(to: .init(x: halfWidth - halfPlusWidth, y: halfHeight))
        plusPath.addLine(to: .init(x: halfWidth + halfPlusWidth, y: halfHeight))
        plusPath.move(to: .init(x: halfWidth, y: halfHeight - halfPlusWidth))
        plusPath.addLine(to: .init(x: halfWidth, y: halfHeight + halfPlusWidth))
        tintColor.setStroke()
        plusPath.stroke()
    }

    private func setupView() {
        backgroundColor = .clear
    }
}
