//
//  UITableViewCell.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 09.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift

private var prepareForReuseBag: Int8 = 0

@objc public protocol Reusable : class {
    func prepareForReuse()
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
extension UICollectionReusableView: Reusable {}

extension Reactive where Base: Reusable {
    var prepareForReuse: Observable<Void> {
        return Observable.of(sentMessage(#selector(Base.prepareForReuse)).map { _ in }, deallocated).merge()
    }
    
    var reuseBag: DisposeBag {
        MainScheduler.ensureExecutingOnScheduler()
        
        if let bag = objc_getAssociatedObject(base, &prepareForReuseBag) as? DisposeBag {
            return bag
        }
        
        let bag = DisposeBag()
        objc_setAssociatedObject(base, &prepareForReuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        _ = sentMessage(#selector(Base.prepareForReuse))
            .subscribe(onNext: { [weak base] _ in
                let newBag = DisposeBag()
                guard let base = base else {
                    return
                }
                objc_setAssociatedObject(base, &prepareForReuseBag, newBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            })
        
        return bag
    }
}
