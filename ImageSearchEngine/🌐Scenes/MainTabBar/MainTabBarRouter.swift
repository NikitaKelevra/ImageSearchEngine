//
//  MainTabBarRouter.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

// Протокол управления слоем навигации модуля MainTabBar
protocol MainTabBarRoutable {
    /// Переход к `BasketVC`
    func routeToBasket()
}

/// #Слой навигации модуля MainTabBar
final class MainTabBarRouter {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

// MARK: - MainTabBarRoutable
extension MainTabBarRouter: MainTabBarRoutable {

    func routeToBasket() {
//        guard let navigationController = navigationController else {return}
//        let viewController = BasketAssembly(navigationController: navigationController).assembly()

        /// Добавляем кастомный переход
//        navigationController.createCustomTransition(with: .moveIn)
//        navigationController.pushViewController(viewController, animated: false)
    }
}
