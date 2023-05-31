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

    var keychainStorageService = ServiceAssembly().keychainStorageService
    
    private var rootVС: UIViewController?
    private var window: UIWindow?
    private let userDefaults: LocalDataManagerProtocol
    private let tokenCheckerManager: ITokenCheckerManagement
    
    init(window: UIWindow?) {
        self.window = window
        self.userDefaults = LocalDataManager()
        self.tokenCheckerManager = TokenCheckerManager(keychainStorageService: KeychainStorageService.shared)
    }
    
    func start() {
        setupElementAppearence() /// Настройка элементов приложения
        setupWindow()
    }

    private func setupWindow() {
        
        
        // 0. Замокаем данные для теста
        UserDefaults.standard.set("TestLogin", forKey: "lastLogin")

        keychainStorageService.delete(service: "access-token-sbmp", account: "TestLogin", completion: { someResult in
          print(someResult)
        })

        keychainStorageService.save("testToken", service: "access-token-sbmp", account: "TestLogin") { someResult in
          print(someResult)
        }



        // 1. Берем username(login)
        if let lastUserLogin = UserDefaults.standard.object(forKey: "lastLogin") as? String {
          // 1.1 Проверяем, есть ли токен у этого пользователя в keychain
          tokenCheckerManager.checkTokenInLocalStorage(for: lastUserLogin) { result in
            switch result {
            case .success:
                routeToMainVC()
            case .failure(let error):
              print(error.localizedDescription)
              createAndShowStartVC()
            }
          }
        }
        
        
        
        
        
        
        
//        setupElementAppearence()
//
//        let tabBarController = MainTabBarAssembly().createModule() /// Создаем Tab Bar
//        rootVС = UINavigationController(rootViewController: tabBarController)
        
//        window?.rootViewController = rootVС
//        window?.makeKeyAndVisible()
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

// MARK: - ApplicationCoordinator
private extension ApplicationCoordinator {
    
    func routeToMainVC() {
        let tabBarController = MainTabBarAssembly().createModule() /// Создаем Tab Bar
        rootVС = UINavigationController(rootViewController: tabBarController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVС
        window?.makeKeyAndVisible()
    }
    
    func createAndShowStartVC() {
        let startVC = LoginViewController(nibName: String(describing: LoginViewController.self), bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: startVC)
        
        let loginAssembly = LoginAssembly(navigationController: navigationController)
        loginAssembly.configure(viewController: startVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
