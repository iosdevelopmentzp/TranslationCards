//
//  MainNavigationViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 22.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MainNavigationViewModelInput {
    var createCardTap: PublishSubject<Void> { get }
}

protocol MainNavigationViewModelOutput {}

protocol MainNavigationViewModelType {
    var input: MainNavigationViewModelInput { get }
    var output: MainNavigationViewModelOutput { get }
}

extension MainNavigationViewModelType where Self:  MainNavigationViewModelInput & MainNavigationViewModelOutput {
    var input: MainNavigationViewModelInput { self }
    var output: MainNavigationViewModelOutput { self }
}

final class MainNavigationViewModel: NavigationViewModel<MainNavigationRouter>, MainNavigationViewModelInput, MainNavigationViewModelOutput, MainNavigationViewModelType {
    
    let createCardTap = PublishSubject<Void>()
    
    private let transitionAnimator = TransitionAnimator()
    
    override init() {
        super.init()
        navigationControllerDelegate = NavigationControllerDelegate(transitionAnimator: transitionAnimator)
        modalTransitionAnimatorDelegate = ModalTransitionAnimationDelegate(modalAnimator: ModalTransitionAnimator())
        
        createCardTap
            .withLatestFrom(services.credentials.user)
            .compactMap { [weak self] user -> User? in
                guard let user = user else {
                    self?.alertModel.accept(.warningAlert(message: "An unsuccessful attempt to take the user. The current user is nil.", handler: nil))
                    return nil
                }
                return user }
            .compactMap { [weak self] user -> (User, LanguageBind)? in
                guard let nativeLanguage = user.nativeLanguage else {
                    self?.alertModel.accept(.warningAlert(message: "User does't have a native language.", handler: nil))
                    return nil
                }
                let sourceLanguage = user.currentLanguage ?? nativeLanguage.next()
                let languageBind = LanguageBind(source: nativeLanguage, target: sourceLanguage)
                return (user, languageBind) }
            .subscribe(onNext: { [weak self] (user, languageBind) in
                self?.router.route(to: .createCard(user: user, language: languageBind))
            })
            .disposed(by: disposeBag)
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
}
