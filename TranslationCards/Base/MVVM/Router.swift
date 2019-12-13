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
    
    required override init() {
        super.init()
    }
    
    func routeToStartController() {
        guard let startVc = viewController?.navigationController?.viewControllers.first else {
            return
        }
        viewController?.navigationController?.popToViewController(startVc, animated: true)
    }
}
