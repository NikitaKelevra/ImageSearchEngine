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
    ///  - assenblyingModule: создание VC через соответствующий модуль Assemblying
    ///  - title: название
    ///  - image: изображение
    /// - Returns: NavigationVC
    private func generateNaviController(assenblyingModule: Assemblying,
                                              title: String,
                                              image: UIImage?) -> UIViewController {
        
        let vc = assenblyingModule.createModule() /// Создаем модуль View Controller'a
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
}

// MARK: - TabBarConfiguration
extension TabBarConfigurator: TabBarConfiguration {

    func generate(tabBar: UITabBarController) {
        /// Конфигурируем модуль для первой вкладки
        let advanceNC = UINavigationController()
        let advanceVC = generateNaviController(assenblyingModule: AdvancedModuleAssembly(navigationController: advanceNC),
                                               title: "All Photos".localize(),
                                               image: UIImage(systemName: "gear"))
        advanceNC.viewControllers = [advanceVC]
        
        /// Конфигурируем модуль для второй вкладки
        let favoriteNC = UINavigationController()
        let favoriteVC = generateNaviController(assenblyingModule: FavoriteModuleAssembly(navigationController: favoriteNC),
                                                title: "My Favourites".localize(),
                                                image: UIImage(systemName: "heart"))
        favoriteNC.viewControllers = [favoriteVC]
        
        /// Добавляем контроллеры во вкладки `TabBar`
        tabBar.viewControllers = [
            advanceNC,
            favoriteNC
        ]
    }
}

