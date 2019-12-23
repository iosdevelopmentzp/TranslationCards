//
//  ViewController.swift
//  TrailTest
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 dmitriy. All rights reserved.
//

import UIKit
import RxSwift
import JJFloatingActionButton
import NVActivityIndicatorView

class ViewController<R: Router, VM: ViewModel<R>>: UIViewController {
    
    let viewModel: VM
    let disposeBag = DisposeBag()
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.router.viewController = self
        self.viewModel.updated = { [weak self] in
            self?.onModelUpdates()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if DEBUG
    deinit {
        debugPrint("\(self) deinited.")
    }
    #endif
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .mainBackgroundColor
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        binding()
        setupTable()
        localizable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionButtons()
    }
    
    func onModelUpdates() {}
    func setupConstraints() {}
    func setupView() {}
    func setupTable() {}
    func setupNavigationBar() {}
    func localizable() {}
    func binding() {
        // default binding
        viewModel
            .textFieldAlertModel
            .observeOn(MainScheduler.instance)
            .compactMap { $0 }
            .subscribe(onNext: { (model) in
                let alert = TextFieldAlertBuilder.buildTextFieldAlert(for: model)
                DispatchQueue.main.async { [weak self] in
                    self?.present(alert, animated: true, completion: nil)
                }
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
            .subscribe(onNext: { isActive in
                let indicator =  NVActivityIndicatorPresenter.sharedInstance
                guard isActive != indicator.isAnimating else {
                    return
                }
                guard isActive else {
                    indicator.stopAnimating()
                    return
                }
                let activityData = ActivityData()
                indicator.startAnimating(activityData)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func setupActionButtons() {
        guard let mainNavigation = navigationController as? MainNavigationViewController else {
            return
        }
        
        guard let buttonDataSource = self as? ActionButtonDataSource else {
            mainNavigation.configureActionButtons([])
            return
        }
        
        let buttons = buttonDataSource.getActionButtons()
        mainNavigation.configureActionButtons(buttons)
    }
}
