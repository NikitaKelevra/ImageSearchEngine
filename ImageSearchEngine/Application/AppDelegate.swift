//
//  AppDelegate.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        /// Настройка и запуск стартового экрана приложения
        ApplicationCoordinator(window: window).start()
        
        return true
    }
}
