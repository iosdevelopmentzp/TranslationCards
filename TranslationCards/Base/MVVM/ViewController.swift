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
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
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
        viewModel
            .alertModel
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (alertModel) in
                guard let model = alertModel else { return }
                let alert = AlertBuilder.buildAlertController(for: model)
                self?.present(alert, animated: true, completion: nil) })
            .disposed(by: disposeBag)
        
        setupView()
        setupTable()
        setupNavigationBar()
        localizable()
        binding()
    }
    
    func onModelUpdates() {}
    func setupConstraints() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    func setupView() {
        activityIndicator.hidesWhenStopped = true
    }
    func setupTable() {}
    func setupNavigationBar() {}
    func localizable() {}
    func binding() {
        viewModel
            .startActivityIndicator
            .subscribe(onNext: { [weak self] (isActive) in
                isActive ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
                guard isActive, let activityIndicator = self?.activityIndicator else {
                    return
                }
                self?.view.bringSubviewToFront(activityIndicator)
            })
            .disposed(by: disposeBag)
    }
}
