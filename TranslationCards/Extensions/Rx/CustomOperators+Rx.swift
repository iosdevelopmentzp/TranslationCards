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



func <-> <T: Equatable>(lhs: BehaviorRelay<T>, rhs: BehaviorRelay<T>) -> Disposable {
    typealias ItemType = (current: T, previous: T)
    
    return Observable.combineLatest(lhs.currentAndPrevious(), rhs.currentAndPrevious())
        .filter({ (first: ItemType, second: ItemType) -> Bool in
            return first.current != second.current
        })
        .observeOn(MainScheduler.asyncInstance)
        .subscribe(onNext: { (first: ItemType, second: ItemType) in
            if first.current != first.previous {
                rhs.accept(first.current)
            }
            else if (second.current != second.previous) {
                lhs.accept(second.current)
            }
        })
}

extension ObservableType {
  func currentAndPrevious() -> Observable<(current: Element, previous: Element)> {
    return self.multicast({ () -> PublishSubject<Element> in PublishSubject<Element>() }) { (values: Observable<Element>) -> Observable<(current: Element, previous: Element)> in
      let pastValues = Observable.merge(values.take(1), values)
      
      return Observable.combineLatest(values.asObservable(), pastValues) { (current, previous) in
        return (current: current, previous: previous)
      }
    }
  }
}
