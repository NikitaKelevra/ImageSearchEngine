//
//  MainTabBarAssembly.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

final class MainTabBarAssembly {
    
    private let navigationController: UINavigationController
    private let tabBarConfigurator: TabBarConfiguration

    init(navigationController: UINavigationController,
         tabBarConfigurator: TabBarConfiguration) {
        self.navigationController = navigationController
        self.tabBarConfigurator = tabBarConfigurator

        /// Скрываем `navigationBar` для `TabBar`
        navigationController.navigationBar.isHidden = true
    }
}

// MARK: - Assemblying
extension MainTabBarAssembly: Assemblying {
    
    func createModule() -> UIViewController {
        let router = MainTabBarRouter(navigationController: navigationController)
        let tabBarController = MainTabBarController()
        tabBarConfigurator.generate(tabBar: tabBarController)
        return tabBarController
    }
}
