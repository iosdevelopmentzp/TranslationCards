//
//  CustomOperators+Rx.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 08.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - Reverse observable
infix operator <-> : DefaultPrecedence

/// Two way binding operator between control property and relay, that's all it takes.
func <-><T: Any> (property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            relay.accept(n)
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
