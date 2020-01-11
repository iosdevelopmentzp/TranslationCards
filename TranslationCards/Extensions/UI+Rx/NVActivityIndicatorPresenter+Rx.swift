//
//  NVActivityIndicatorPresenter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 11.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import NVActivityIndicatorView

extension NVActivityIndicatorPresenter {
    public var rx_isAnimating: Binder<Bool> {
        return Binder(self) { [weak self] activityIndicator, animate in
            guard let isAnimating = self?.isAnimating, animate != isAnimating else { return }
            if animate {
                let activityData = ActivityData()
                activityIndicator.startAnimating(activityData)
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
}
