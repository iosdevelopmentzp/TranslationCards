//
//  NavigationViewModel.swift
//  ToDo
//
//  Created by krazke on 6/13/19.
//  Copyright © 2019 sowonderfultodo. All rights reserved.
//

import RxSwift
import LifetimeTracker

class NavigationViewModel<R: Router>: NSObject, LifetimeTrackable {

    static var lifetimeConfiguration: LifetimeConfiguration {
        return LifetimeConfiguration(maxCount: 2, groupName: "NavigationViewModel")
    }

    let disposeBag = DisposeBag()

    let router: R
    let root: UIViewController

    init(root: UIViewController) {
        router = R()
        self.root = root
        super.init()
        trackLifetime()
    }
}
