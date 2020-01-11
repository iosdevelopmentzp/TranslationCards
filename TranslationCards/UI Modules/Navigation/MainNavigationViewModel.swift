//
//  MainNavigationViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

final class MainNavigationViewModel: NavigationViewModel<MainNavigationRouter> {
    
    private let transitionAnimator = TransitionAnimator()
    
    override init() {
        super.init()
        navigationControllerDelegate = NavigationControllerDelegate(transitionAnimator: transitionAnimator)
        modalTransitionAnimatorDelegate = ModalTransitionAnimationDelegate(modalAnimator: ModalTransitionAnimator())
    }

    func willPresentViewController(_ viewControllerToPresent: UIViewController, isAnimated: Bool) {
        guard isAnimated else {
            return
        }

        if let modalAnimator = modalTransitionAnimatorDelegate,
            modalAnimator.animator.isValidatedPresentedViewController(viewControllerToPresent) {
            viewControllerToPresent.modalPresentationStyle = .custom
            viewControllerToPresent.transitioningDelegate = modalAnimator
        }
    }
    
    func bind(addCardPressed plusPressed: ControlEvent<Void>) {
        plusPressed.subscribe(onNext: { [weak self] _ in
            guard let user = self?.services.credentials.user.value else {
                self?.alertModel.accept(.warningAlert(message: "Failed to get current user", handler: nil))
                return
            }
            guard let nativeLanguage = user.nativeLanguage else {
                self?.alertModel.accept(.warningAlert(message: "User does't have a native language", handler: nil))
                return
            }
            
            let sourceLanguage = user.currentLanguage ?? nativeLanguage.next()
            let languageBind = LanguageBind(source: nativeLanguage, target: sourceLanguage)
            self?.router.route(to: .createCard(user: user, language: languageBind))
        })
        .disposed(by: disposeBag)
    }
}
