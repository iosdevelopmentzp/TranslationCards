//
//  CustomOperators.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 13.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa


// MARK: - Compare optional objects
infix operator ==? : ComparisonPrecedence

func ==? <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func ==? <T: AnyObject>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs === rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func ==? <T: Equatable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

// MARK: - Reverse observable

infix operator <-> : DefaultPrecedence

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
