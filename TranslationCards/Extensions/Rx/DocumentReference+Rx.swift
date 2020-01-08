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
        base.rx
            .getDocument()
            .map { $0.exists }
    }
}
