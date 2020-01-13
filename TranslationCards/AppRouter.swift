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
            .filter{ $0 == nil }
            .subscribe(onNext: { [weak self] (user) in
                self?.openLoginScreenIfNeed()
            })
            .disposed(by: disposeBag)
    }
    
    func buildStartView() -> UIViewController {
        var viewControllersStack:[UIViewController] = []
        
        let user = services.credentials.user.value
        
        switch user {
        case .none:
            let loginVc = Screens.logIn()
            viewControllersStack.append(loginVc)
        case .some(let user) where user.nativeLanguage == nil:
            let selectLangVC = Screens.choosingNativeLanguage(forUser: user)
            viewControllersStack.append(selectLangVC)
        default:
            let mainVC = Screens.mainScreen()
            viewControllersStack.append(mainVC)
        }
        navigationController.setViewControllers(viewControllersStack, animated: false)
        return navigationController
    }
    
    // MARK: - Private
    private func openLoginScreenIfNeed() {
        if let topViewController = navigationController.viewControllers.last,
            topViewController is LogInViewController {
            return
        } else {
            let loginVC = Screens.logIn()
            navigationController.setViewControllers([loginVC], animated: true)
        }
    }
}
