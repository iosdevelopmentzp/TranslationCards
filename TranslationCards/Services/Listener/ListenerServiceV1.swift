//
//  ListenerServiceV1.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseFirestore
import RxFirebaseFirestore

class ListenerServiceV1: NSObject, ListenerService {
    fileprivate let database = Firestore.firestore()
    fileprivate let disposeBag = DisposeBag()
    
    func listenLanguageBindList(forUserWithId userId: String) -> Observable<ChangedDocuments<LanguageBind>> {
        
        return .create { [weak self] (observer) -> Disposable in
            self?.database
                .collection(.databaseUserCollection)
                .document(userId)
                .collection(.databaseLanguagesCollection)
                .addSnapshotListener { (snapshot, error) in
                    if let error = error {
                        observer.onError(error)
                        return
                    }
                    guard let snapshot = snapshot, snapshot.documentChanges.count > 0 else { return }
                    let changedDocumentsList = ChangedDocuments<LanguageBind>.processSnapshot(snapshot)
                    guard changedDocumentsList.count > 0 else { return }
                    changedDocumentsList.forEach {
                        observer.onNext($0)
                    }
            }
            return Disposables.create()
        }
    }
}


class ChangedDocuments<Element: DataRepresentation> {
    let type: DocumentChangeType
    let changedObjects: [Element]
    
    init(changedObjects: [Element], type: DocumentChangeType) {
        self.type = type
        self.changedObjects = changedObjects
    }
    
    static func processSnapshot(_ snapshot: QuerySnapshot) -> [ChangedDocuments<Element>] {
        guard snapshot.documentChanges.count > 0 else {
            return []
        }
        
        var changedDocuments: [ChangedDocuments<Element>] = []
        
        DocumentChangeType.allCases.forEach { (type) in
            let objects = snapshot
                .documentChanges.filter{ $0.type == type }
                .map{ Element(withData: $0.document.data()) }
                .compactMap{ $0 }
            guard objects.count > 0 else { return }
            let currentChangedDocuments = ChangedDocuments<Element>(changedObjects: objects, type: type)
            changedDocuments.append(currentChangedDocuments)
        }
        return changedDocuments
    }
}

extension DocumentChangeType {
    static var allCases: [DocumentChangeType] = [.added, .removed, .modified]
}
