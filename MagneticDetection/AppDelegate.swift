//
//  AppDelegate.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = .init(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        showMainVC()
        setupTabBarchik()
        
        return true
    }
}

//MARK: - AppDelegate
private extension AppDelegate {
    func showMainVC() {
        let maimVC = MainVC()
        let navigationController = UINavigationController(rootViewController: maimVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setupTabBarchik() {
        let tabbarFont = UIFont(name: "Roboto-Medium", size: 18)
        
        UINavigationBar.appearance().barTintColor = .customBlack
        UINavigationBar.appearance().backgroundColor = .customBlack
        UINavigationBar.appearance().tintColor = .customViolet
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : tabbarFont!]
        UINavigationBar.appearance().isTranslucent = false
    }
}
