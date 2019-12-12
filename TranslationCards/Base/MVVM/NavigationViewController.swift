//
//  NAvigationViewController.swift
//  ToDo
//
//  Created by krazke on 6/13/19.
//  Copyright © 2019 sowonderfultodo. All rights reserved.
//

import RxSwift

class NavigationViewController<R: Router, VM: NavigationViewModel<R>>: UINavigationController {

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
        setupAppereance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    // MARK: - Private
    fileprivate func setupAppereance() {
        let barItemAppearace = UIBarButtonItem.appearance()
        barItemAppearace.setTitleTextAttributes(NSAttributedString.navigationBarButtomItemAttribute, for: .normal)
        barItemAppearace.setTitleTextAttributes(NSAttributedString.navigationBarButtomItemAttribute, for: .highlighted)
        let navigationBarAppearace = UINavigationBar.appearance()
        if #available(iOS 13.0, *) {
            let navBarAppearace = UINavigationBarAppearance()
            navBarAppearace.backgroundColor = .mainDarkColor
            navBarAppearace.titleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            navBarAppearace.largeTitleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            UINavigationBar.appearance().standardAppearance = navBarAppearace
            UINavigationBar.appearance().prefersLargeTitles = true
        } else {
            navigationBarAppearace.barTintColor = .mainDarkColor
            navigationBarAppearace.tintColor = .white
            navigationBarAppearace.isTranslucent = false
            navigationBarAppearace.titleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            navigationBarAppearace.largeTitleTextAttributes = NSAttributedString.navigationBarTitleAttribute
            navigationBarAppearace.prefersLargeTitles = true
        }
    }
    
    func setupView() { }
    
    func bind() {
        delegate = viewModel.navigationControllerDelegate
    }
}
