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

    private var rootVС: UIViewController?
    private var window: UIWindow?
    private let userDefaults: LocalDataManagerProtocol

    init(window: UIWindow?,
         userDefaults: LocalDataManagerProtocol) {
        self.window = window
        self.userDefaults = userDefaults
    }
    
    func start() {
        setupWindow()
        setupElementAppearence()
    }

    private func setupWindow() {
        setupElementAppearence() /// Настройка элементов приложения
        
        let tabBarController = MainTabBarAssembly().createModule() /// Создаем Tab Bar
        rootVС = UINavigationController(rootViewController: tabBarController)
        
        window?.rootViewController = rootVС
        window?.makeKeyAndVisible()
    }

    // Настраиваем свойства UINavigationBar по дефолту в приложении
    private func setupElementAppearence() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel".localize()
    }
}
