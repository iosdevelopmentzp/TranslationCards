//
//  NAvigationViewController.swift
//  ToDo
//
//  Created by krazke on 6/13/19.
//  Copyright © 2019 sowonderfultodo. All rights reserved.
//

import RxSwift
import LifetimeTracker

class NavigationViewController<R: Router, VM: NavigationViewModel<R>>: UINavigationController, LifetimeTrackable {

    static var lifetimeConfiguration: LifetimeConfiguration {
        return LifetimeConfiguration(maxCount: 2, groupName: "NavigationViewController")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    let disposeBag = DisposeBag()

    let viewModel: VM

    required init?(coder _: NSCoder) {
        fatalError()
    }

    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
        setViewControllers([viewModel.root],
                           animated: false)
        self.viewModel.router.viewController = self

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.barTintColor = .black
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        trackLifetime()
    }
}
