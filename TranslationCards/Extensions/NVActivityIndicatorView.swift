//
//  NVActivityIndicatorPresenter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import NVActivityIndicatorView

extension NVActivityIndicatorView {
    static func setupAppereance() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballTrianglePath
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.black.withAlphaComponent(0.3)
    }
}
