//
//  MainRouter.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 13.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

class AppRouter: NSObject {
    
    private let navigationController = Screens.navigation()
    private let services = Services.shared
    private let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
        services
            .credentials
            .user
            .skip(1)
            .subscribe(onNext: { [weak self] (user) in
                self?.didChangeUser(user)
            })
            .disposed(by: disposeBag)
    }
    
    func buildStartView() -> UIViewController {
        var startViewControllers:[UIViewController] = []

        guard let user = services.credentials.user.value else  {
            let loginVc = Screens.logIn()
            startViewControllers.append(loginVc)
            navigationController.setViewControllers(startViewControllers, animated: false)
            return navigationController
        }
        
        guard user.nativeLanguage != nil else {
            let choiceLangVC = Screens.nativeLanguageChoise(user: user)
            startViewControllers.append(choiceLangVC)
            navigationController.setViewControllers(startViewControllers, animated: false)
            return navigationController
        }
        
        let mainVC = Screens.main()
        startViewControllers.append(mainVC)
        navigationController.setViewControllers(startViewControllers, animated: false)
        return navigationController
    }
    
    // MARK: - Private
    private func didChangeUser(_ user: User?) {
        if user == nil {
            openLoginViewIfNeed()
        }
    }
    
    private func openLoginViewIfNeed() {
        if let topViewController = navigationController.viewControllers.last,
            topViewController is LogInViewController {
            return
        } else {
            let loginVC = Screens.logIn()
            navigationController.setViewControllers([loginVC], animated: true)
        }
    }
}
