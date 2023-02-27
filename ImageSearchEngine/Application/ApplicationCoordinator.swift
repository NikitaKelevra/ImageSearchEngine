//
//  ApplicationCoordinator.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

// MARK: - Протокол координатора
protocol Coordinator {
    func chooseStartVC() -> UIViewController
}

// MARK: - Координатор приложения
final class ApplicationCoordinator: Coordinator {

    private var rootViewController = UIViewController()
    private let userDefaults = UserDefaultsManager.shared

    func chooseStartVC() -> UIViewController {
        setupElementAppearence()
        
        let tabBarController = MainTabBarAssembly().createModule() /// Создаем Tab Bar
        rootViewController = UINavigationController(rootViewController: tabBarController)
        
        return rootViewController
    }

    // Настраиваем свойства UINavigationBar по дефолту в приложении
    private func setupElementAppearence() {
//        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController.navigationBar.shadowImage = UIImage()
//        navigationController.navigationBar.tintColor = .black
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().isTranslucent = false
//
//        UITableView.appearance().tableHeaderView = .init(frame: CGRect(x: 0, y: 0, width: 0, height: CGFLOAT_MIN))
//        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel".localize()
    }
}
