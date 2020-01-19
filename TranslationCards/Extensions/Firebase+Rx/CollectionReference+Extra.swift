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

extension Reactive where Base: CollectionReference {
    func addSnapshotListener() -> Observable<[QueryDocumentSnapshot]> {
        .create { (observable) -> Disposable in
            let listener = self.base.addSnapshotListener { (snapshot, error) in
                if let error = error {
                    observable.onError(error)
                    return
                }
                if let documents = snapshot?.documents {
                    observable.onNext(documents)
                }
            }
            return Disposables.create { [weak listener] in
                listener?.remove()
            }
        }
    }
}
