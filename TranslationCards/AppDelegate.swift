//
//  AppDelegate.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 20.11.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        setupView()
        return true
    }
    
    // MARK: - Private
    fileprivate func setupView() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = Screens.logIn()
        window.makeKeyAndVisible()
    }
}

