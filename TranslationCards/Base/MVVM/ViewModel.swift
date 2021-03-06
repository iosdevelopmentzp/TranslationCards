//
//  ViewModel.swift
//  TrailTest
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 dmitriy. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class ViewModel<R: Router>: NSObject {
    
    let disposeBag = DisposeBag()
    let router: R
    let services = Services.shared
    let alertModel = BehaviorRelay<AlertModel?>.init(value: nil)
    let textFieldAlertModel = BehaviorRelay<TextFieldAlertModel?>.init(value: nil)
    let startActivityIndicator: BehaviorRelay<Bool> = .init(value: false)
    
    #if DEBUG
       deinit {
           debugPrint("\(self) deinited.")
       }
    #endif
    
    override init() {
        router = R()
        super.init()
    }
    
    func errorHandler(description: String, error: Error, withAlert: Bool, handler: ((UIAlertAction)->())? = nil) {
        let description = description + "With error - \(error.localizedDescription)"
        debugPrint(description)
        if withAlert {
            alertModel.accept(.warningAlert(message: description, handler: handler))
        }
    }
}
