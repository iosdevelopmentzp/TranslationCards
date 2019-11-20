//
//  ViewModel.swift
//  TrailTest
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 dmitriy. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel<R: Router>: NSObject {
    
    let disposeBag = DisposeBag()
    let router: R
    var updated = {}
    
    override init() {
        router = R()
        super.init()
    }
}
