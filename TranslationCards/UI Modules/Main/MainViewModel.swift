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
    var signOutTap: PublishSubject<Void> { get }
    var tableViewItemTap: PublishSubject<IndexPath> { get }
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
    
    let signOutTap = PublishSubject<Void>()
    let tableViewItemTap = PublishSubject<IndexPath>()
    let sections = BehaviorRelay<[MainViewModelSection]>.init(value: [])
    let isRefreshing: BehaviorRelay<Bool> = .init(value: true)
    
    override init() {
        super.init()
        
        let user = services.credentials.user
        
        isRefreshing
            .distinctUntilChanged()
            .filter{ $0 }
            .ignoreAll()
            .withLatestFrom(user)
            .unwrap()
            .subscribe(onNext: { [weak self] (user) in
                    self?.fetchLanguages(forUser: user)
            })
            .disposed(by: disposeBag)
        
        user.value?.languages
            .map {
                let languages = $0 ?? []
                let section = MainViewModelSection(items: languages)
                return [section] }
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        signOutTap
            .subscribe(onNext: { [weak self] (_) in
                self?.tryToSignOut()
            } )
            .disposed(by: disposeBag)
        
        tableViewItemTap
            .map{ [weak self] in return self?.sections.value[$0.section].items[$0.row] }
            .withLatestFrom(user) { ($0, $1) }
            .compactMap {
                guard let language = $0, let user = $1 else { return nil }
                return (language, user) }
            .subscribe(onNext: { [weak self] (language, user) in
                self?.router.route(to: .cardList(language: language, user: user))
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    private func tryToSignOut() {
        services.auth.signOut()
            .catchError { [weak self] (error) -> Observable<()> in
                self?.errorHandler(description: "Failed attempt to sign out", error: error, withAlert: true)
                return .never() }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func fetchLanguages(forUser user: User) {
        if isRefreshing.value == false {
            isRefreshing.accept(true)
        }
        user.fetchLanguages()
            .catchError({ [weak self] (error) -> Observable<()> in
                self?.errorHandler(description: "Failed to attempt update langugae list", error: error, withAlert: true)
                return .just(())
            })
            .map { false }
            .bind(to: isRefreshing)
            .disposed(by: disposeBag)
    }
}
