//
//  SceneDelegate.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // Настройка сцены - окна window и выбор стартового View Controller
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let rootVC = ApplicationCoordinator().chooseStartVC()
        
        if let window = window {
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
    }
}

