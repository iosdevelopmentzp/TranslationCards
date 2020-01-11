//
//  Router.swift
//  TrailTest
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 dmitriy. All rights reserved.
//

import UIKit

class Router: NSObject {
    weak var viewController: UIViewController?
    
    func comeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    required override init() {
        super.init()
    }
}
