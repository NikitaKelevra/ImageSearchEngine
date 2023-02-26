//
//  AdvancedModuleAssembly.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.02.2023.
//

import UIKit

// Advanced Module Assembly предназначен для создания модуля Advanced View Controller
final class AdvancedModuleAssembly {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension AdvancedModuleAssembly: Assemblying {
    func createModule() -> UIViewController {
        
        /// Менеджер для работы перехода на дрегие экраны
        let router = AdvancedRouter(navigationController: navigationController)
        /// Менеджер для работы с сетью
        let fetcher = NetworkDataFetcher()
        
        let viewModel = AdvancedViewModel(router: router,
                                          fetcher: fetcher)
        let VC = AdvancedViewController(viewModel: viewModel)
        return VC
    }
}
