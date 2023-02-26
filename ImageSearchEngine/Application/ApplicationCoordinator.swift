//
//  ApplicationCoordinator.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

// MARK: - Протокол координатора
protocol Coordinator {
    func start()
}

// MARK: - Координатор приложения
final class ApplicationCoordinator: Coordinator {

    private var rootViewController: UIViewController?
    private var window: UIWindow?
    private let userDefaults: UserDefaultsVerifable

    init(window: UIWindow?,
         userDefaults: UserDefaultsVerifable) {
        self.window = window
        self.userDefaults = userDefaults
    }

    func start() {
        setupWindow()
        setupElementAppearence()
    }

    private func setupWindow() {

        let navigationVC = UINavigationController()
        let tabBarConfigurator = TabBarConfigurator()
        let tabBarController = MainTabBarAssembly(navigationController: navigationVC,
                                                  tabBarConfigurator: tabBarConfigurator).createModule()
        navigationVC.viewControllers = [tabBarController]
        rootViewController = navigationVC
        
        
        if userDefaults.checkReady() {
            /// Если пользователь уже просматривал экран `Launch`
            /// Устанавливаем зависимости и настраиваем TabBarController
            
        } else {
            /// Если нет - настраиваем модуль `Launch`
            ///
//            let viewController = LaunchAssembly().assembly()
//            rootViewController = viewController
        }
        
        
        window?.backgroundColor = .white
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

    // Настраиваем свойства UINavigationBar по дефолту в приложении
    private func setupElementAppearence() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .black
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//        UINavigationBar.appearance().tintColor = .black
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = false
//
//        UITableView.appearance().tableHeaderView = .init(frame: CGRect(x: 0, y: 0, width: 0, height: CGFLOAT_MIN))
//        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel".localize()
    }
}
