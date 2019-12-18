//
//  NavigationViewModel.swift
//  ToDo
//
//  Created by krazke on 6/13/19.
//  Copyright © 2019 sowonderfultodo. All rights reserved.
//

import RxSwift
import RxCocoa

class NavigationViewModel<R: Router>: NSObject {
    
    let disposeBag = DisposeBag()
    let services = Services.shared
    let router: R
    var alertModel = BehaviorRelay<AlertModel?>.init(value: nil)
    
    var modalTransitionAnimatorDelegate: ModalTransitionDelegate?
    var navigationControllerDelegate: UINavigationControllerDelegate?

    override init() {
        router = R()
        super.init()
    }
}
