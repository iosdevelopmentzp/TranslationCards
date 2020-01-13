//
//  ObservableType+UIExtras.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 13.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func executeWithAnimation(duration: TimeInterval, animationBlock: @escaping (Element) -> Void) -> Observable<Element> {
        return flatMap { result in
            return Observable
                .just(
                {
                    UIView.animate(withDuration: duration) {
                        animationBlock(result)
                    }
                }() )
                .map{_ in result }
                .take(1)
        }
    }
}
