//
//  ViewModel.swift
//  TrailTest
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 dmitriy. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class ViewModel<R: Router>: NSObject, ServicesAccessing {
    
    let disposeBag = DisposeBag()
    let router: R
    var updated = {}
    var alertModel = BehaviorRelay<AlertModel?>.init(value: nil)
    var startActivityIndicator: BehaviorRelay<Bool> = .init(value: false)
    
    #if DEBUG
       deinit {
           debugPrint("\(self) deinited.")
       }
    #endif
    
    override init() {
        router = R()
        super.init()
        bindWithServices()
    }
    
    func bindWithServices() {}
}
