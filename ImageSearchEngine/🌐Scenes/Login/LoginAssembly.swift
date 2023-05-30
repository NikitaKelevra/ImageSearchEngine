//
//  LoginAssembly.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 30.05.2023.
//

import UIKit

// Login Assembly предназначен для создания модуля Login View Controller
final class LoginAssembly {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension LoginAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let loginVC = viewController as? LoginViewController else { return }
        
        let router: LoginRouterProtocol = LoginRouter(navigationController: navigationController)
        let localDM: LocalDataManagerProtocol = LocalDataManager()
        var viewModel: LoginViewModelProtocol = LoginViewModel()
        
        loginVC.viewModel = viewModel
        viewModel.router = router
        viewModel.localDataManager = localDM
        
    }
    
}
