//
//  MainViewModel.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 28.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelInput {
    var signOutAction: PublishSubject<Void> { get }
    var selectedAction: PublishSubject<IndexPath> { get }
}

protocol MainViewModelOutput {
    var sections: BehaviorRelay<[MainViewModelSection]> { get }
    var isRefreshing: BehaviorRelay<Bool> { get }
}

protocol MaintViewModelType: MainViewModelInput & MainViewModelOutput {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

extension MaintViewModelType {
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
}

final class MainViewModel: ViewModel<MainRouter>, MaintViewModelType {
    
    let signOutAction = PublishSubject<Void>()
    var selectedAction = PublishSubject<IndexPath>()
    let sections = BehaviorRelay<[MainViewModelSection]>.init(value: [])
    let isRefreshing: BehaviorRelay<Bool> = .init(value: true)
    
    fileprivate var user: User?
    
    override init() {
        super.init()
        user = User.currentUser.value
        
        isRefreshing
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (isRefreshing) in
                if isRefreshing {
                    self?.fetchLanguages()
                }
            })
            .disposed(by: disposeBag)
        
        user?
            .languages
            .map {
                let languages = $0 ?? []
                let section = MainViewModelSection(items: languages)
                return [section] }
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        signOutAction
            .subscribe(onNext: { [weak self] (_) in
                self?.services
                    .auth
                    .signOut()
                    .catchError({ [weak self] (error) -> Observable<()> in
                        self?.errorHandler(description: "Failed sign out action", error: error, withAlert: true)
                    return .error(error)
                    })
                    .subscribe().disposed(by: self?.disposeBag ?? DisposeBag())
            })
            .disposed(by: disposeBag)
        
        selectedAction
            .map{ [weak self] in return self?.sections.value[$0.section].items[$0.row] }
            .unwrap()
            .subscribe(onNext: { [weak self] (language) in
                guard let user = self?.user else { return }
                self?.router.route(to: .cardList(language: language, user: user))
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    fileprivate func fetchLanguages() {
        if isRefreshing.value == false {
            isRefreshing.accept(true)
        }
        self.user?
            .fetchLanguages()
            .catchError({ [weak self] (error) -> Observable<()> in
                self?.errorHandler(description: "Failed to attempt update langugae list", error: error, withAlert: true)
                return .just(())
            })
            .map { false }
            .bind(to: isRefreshing)
            .disposed(by: disposeBag)
    }
}
