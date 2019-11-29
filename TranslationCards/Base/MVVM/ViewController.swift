//
//  ViewController.swift
//  TrailTest
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 dmitriy. All rights reserved.
//

import UIKit
import RxSwift

class ViewController<R: Router, VM: ViewModel<R>>: UIViewController {
    
    let viewModel: VM
    let disposeBag = DisposeBag()
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.router.viewController = self
        self.viewModel.updated = onModelUpdates
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .mainDarkColor
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        setupNavigationBar()
        localizable()
        binding()
    }
    
    func onModelUpdates() {}
    func setupConstraints() {}
    func setupView() {}
    func setupTable() {}
    func setupNavigationBar() {}
    func localizable() {}
    func binding() {}
}
