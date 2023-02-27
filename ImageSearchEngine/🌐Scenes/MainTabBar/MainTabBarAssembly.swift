//
//  MainTabBarAssembly.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

final class MainTabBarAssembly {

}

// MARK: - Assemblying
extension MainTabBarAssembly: Assemblying {
    
    func createModule() -> UIViewController {
        let tabBarController = MainTabBarController()
        let tabBarConfigurator = TabBarConfigurator()
        tabBarConfigurator.generate(tabBar: tabBarController)
        return tabBarController
    }
}
