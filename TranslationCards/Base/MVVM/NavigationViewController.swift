//
//  NAvigationViewController.swift
//  ToDo
//
//  Created by krazke on 6/13/19.
//  Copyright © 2019 sowonderfultodo. All rights reserved.
//

import RxSwift
import JJFloatingActionButton

class NavigationViewController<R: Router, VM: NavigationViewModel<R>>: UINavigationController {

    let disposeBag = DisposeBag()
    let viewModel: VM

    required init?(coder _: NSCoder) {
        fatalError()
    }

    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
        self.viewModel.router.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupView()
        binding()
        localizable()
    }
    
    func localizable() {}
    func setupView() { }
    func setupConstraints() {}
    func binding() {
        defaultBinding()
    }
    
    // MARK: - Private
    private func defaultBinding() {
        delegate = viewModel.navigationControllerDelegate
        viewModel
            .alertModel
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (alertModel) in
                guard let model = alertModel else { return }
                let alert = AlertBuilder.buildAlertController(for: model)
                self?.present(alert, animated: true, completion: nil) })
            .disposed(by: disposeBag)
    }
}
