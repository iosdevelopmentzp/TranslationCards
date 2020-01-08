//
//  ObservableType.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 07.01.2020.
//  Copyright © 2020 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    func execute(_ selector: @escaping (Element) -> Void) -> Observable<Element> {
        return flatMap { result in
             return Observable
                .just(selector(result))
                .map { _ in result }
                .take(1)
        }
    }
    
    func unwrap<T>() -> Observable<T> where Element == T? {
        return compactMap { $0 }
    }
    
    func merge(with other: Observable<Element>) -> Observable<Element> {
        return Observable.merge(self.asObservable(), other)
    }
    
}
