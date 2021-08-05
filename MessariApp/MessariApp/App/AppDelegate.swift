//
//  AppDelegate.swift
//  MessariApp
//
//  Created by Офелия on 28.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
     var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let networking = Networking()
        let vc = ViewController(networkingService: networking)
        let navigation = UINavigationController()
        navigation.viewControllers = [vc]
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }
}

