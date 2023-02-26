//
//  TabBarConfigurator.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

//MARK: - Протокол конфигурации контроллера панели вкладок
protocol TabBarConfiguration {
    /// Настраивает `TabBar` и его дочерние VC
    func generate(tabBar: UITabBarController)
}

/// Конфигуратор `TabBar`
final class TabBarConfigurator {
    
    /// Создание и настройка tabBarItem
    /// - Parameters:
    ///  - viewController: Child-VC
    ///  - title: название
    ///  - image: изображение
    /// - Returns: NavigationVC
    private func generateNaviController(assenblyingModule: Assemblying,
                                              title: String,
                                              image: UIImage?) -> UIViewController {
        /// Создаем модуль
        let rootVC = assenblyingModule.createModule()
        /// Оборачиваем в NavigationController
        let navigationVC = UINavigationController(rootViewController: rootVC)
        /// Настраиваем характеристики
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

// MARK: - TabBarConfiguration
extension TabBarConfigurator: TabBarConfiguration {

    func generate(tabBar: UITabBarController) {
        let navigationVC = UINavigationController()
        /// Создаем дочерние контроллеры и настраиваем их
        let advanceVC = generateNaviController(assenblyingModule: AdvancedModuleAssembly(navigationController: navigationVC),
                                               title: "All Photos".localize(),
                                               image: UIImage(systemName: "gear"))
        
        let favoriteVC = generateNaviController(assenblyingModule: FavoriteModuleAssembly(navigationController: navigationVC),
                                                title: "My Favourites".localize(),
                                                image: UIImage(systemName: "heart"))
        /// Добавляем контроллеры во вкладки `TabBar`
        tabBar.viewControllers = [
            advanceVC,
            favoriteVC
        ]

        tabBar.setViewControllers(tabBar.viewControllers, animated: false)
    }
}

