//
//  MainTabBarController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

// Контроллер панели вкладок
final class MainTabBarController: UITabBarController {
    // MARK: - Properties
    private var layer = CAShapeLayer() /// Слой для `TabBar`
    
    // MARK: - Методы жиненного цикла UITabBarController
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    // MARK: - Private functions
    private func generateTabBar() {
        /// Конфигурируем модуль для первой вкладки
        let navigationController = UINavigationController()
        let advanceVC = AdvancedModuleAssembly(navigationController: navigationController).createModule()
        navigationController.viewControllers = [advanceVC]
        
        // Массив View Controller'ов для панели вкладок
        viewControllers = [
            generateNavigationController(rootViewController: advanceVC,
                                         title: "All Photos".localize(),
                                         image: UIImage(systemName: "gear")),
            generateNavigationController(rootViewController: FavoritePhotoViewController(),
                                         title: "My Favourites".localize(),
                                         image: UIImage(systemName: "heart"))
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationVC.navigationBar.shadowImage = UIImage()
        navigationVC.navigationBar.tintColor = .black
        return navigationVC
    }
    
    // Настраиваем / кастомизируем внешний вид панели вкладок TabBar
    private func setTabBarAppearance() {
        /// Делаем `TabBar` прозрачным
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    
        /// Настраиваем слой `TabBar`
        let x: CGFloat = 10
        let y: CGFloat = 12
        let width = tabBar.bounds.width - x * 2
        let height = tabBar.bounds.height + y * 2

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: x,
                                y: tabBar.bounds.minY - y,
                                width: width,
                                height: height),
            cornerRadius: height / 3
        )
        layer.path = bezierPath.cgPath
        
        /// Настраиваем тени `TabBar`
        layer.shadowColor = UIColor.viewBackgroundColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        
        /// Добавляем слой `TabBar`
        tabBar.layer.insertSublayer(layer, at: 0)
        
         /// Настраиваем элементы `TabBar`
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        
         /// Настраиваем цвета `TabBar`
        layer.fillColor = UIColor.mainBackgroundColor.cgColor
        tabBar.unselectedItemTintColor = .unselectedTextColor
        tabBar.tintColor = .selectesTextColor
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.barTintColor = .black
    }
}
