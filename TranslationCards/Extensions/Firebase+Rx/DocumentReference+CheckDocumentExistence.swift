//
//  Firestore.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 11.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import Firebase
import FirebaseFirestore

extension Reactive where Base: DocumentReference {
    func isDocumentExist() -> Observable<Bool> {
        Observable<Bool>.create { (observer) -> Disposable in
            self.base.getDocument { (snapshot, error) in
                if let error = error {
                    observer.onError(error)
                }
                guard let snapshot = snapshot else {
                    observer.onNext(false)
                    observer.onCompleted()
                    return
                }
                observer.onNext(snapshot.exists)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
