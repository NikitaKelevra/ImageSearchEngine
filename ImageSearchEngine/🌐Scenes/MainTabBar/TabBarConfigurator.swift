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

/// #Конфигуратор TabBar
final class TabBarConfigurator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Настройка tabBarItem
    /// - Parameters:
    ///  - viewController: Child-VC
    ///  - image: изображение
    ///  - selectedImage: изображение при выбранной вкладке
    /// - Returns: Child-VC
    private func setupChildVC(_ viewController: UIViewController,
                              image: UIImage? = nil) -> UIViewController {
        viewController.tabBarItem.image = image
//        viewController.tabBarItem.selectedImage = selectedImage
        return viewController
    }
}

// MARK: - TabBarConfiguration
extension TabBarConfigurator: TabBarConfiguration {

    func generate(tabBar: UITabBarController) {
        /// Конфигурируем модуль для первой вкладки
        let navigationControllerOne = UINavigationController()
        let AdvancedVC = AdvancedModuleAssembly(navigationController: navigationControllerOne).createModule()
        navigationControllerOne.viewControllers = [AdvancedVC]

        /// Конфигурируем модуль для второй вкладки
//        let navigationControllerTwo = UINavigationController()
//        let userProfileVC = UserProfileAssembly(navigationController: navigationControllerTwo).assembly()
//        navigationControllerTwo.viewControllers = [userProfileVC]

        /// Добавляем контроллеры и устанавливаем изображения
        tabBar.viewControllers = [
            setupChildVC(navigationControllerOne,
                         image: UIImage(systemName: "gear")),

            UIViewController(),

            setupChildVC(navigationControllerTwo,
                         image: Icons.person.image,
                         selectedImage: Icons.personFill.image)
        ]

        tabBar.setViewControllers(tabBar.viewControllers, animated: false)
    }
}

