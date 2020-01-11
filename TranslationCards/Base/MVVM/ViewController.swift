//
//  ViewController.swift
//  TrailTest
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 dmitriy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JJFloatingActionButton
import NVActivityIndicatorView

class ViewController<R: Router, VM: ViewModel<R>>: UIViewController {
    
    let viewModel: VM
    let disposeBag = DisposeBag()
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.router.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if DEBUG
    deinit {
        debugPrint("\(self) deinited.")
    }
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupView()
        setupNavigationBar()
        setupTableView()
        setupCollectionView()
        binding()
        localize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionButtons()
    }
    
    func setupConstraints() {}
    func setupView() {
        view.backgroundColor = .mainBackgroundColor
    }
    func setupTableView() {}
    func setupCollectionView() {}
    func setupNavigationBar() {}
    func localize() {}
    func binding() {
        defaultBinding()
    }
    
    // MARK: - Private
    private func defaultBinding() {
        viewModel
            .textFieldAlertModel
            .observeOn(MainScheduler.instance)
            .unwrap()
            .subscribe(onNext: { [weak self] (model) in
                let alert = TextFieldAlertBuilder.buildTextFieldAlert(for: model)
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .alertModel
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (alertModel) in
                guard let model = alertModel else { return }
                let alert = AlertBuilder.buildAlertController(for: model)
                self?.present(alert, animated: true, completion: nil) })
            .disposed(by: disposeBag)
        
        viewModel
            .startActivityIndicator
            .observeOn(MainScheduler.instance)
            .bind(to: NVActivityIndicatorPresenter.sharedInstance.rx_isAnimating)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Private
    private func setupActionButtons() {
        guard let mainNavigation = navigationController as? MainNavigationViewController else {
            return
        }
        let buttons = (self as? ActionButtonDataSource)?.getActionButtons() ?? []
        mainNavigation.configureActionButtons(buttons)
    }
}


