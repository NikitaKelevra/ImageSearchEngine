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
        /// Менеджер перехода на другие экраны
        let router = AdvancedRouter(navigationController: navigationController)
        /// Менеджер для работы с сетью
        let fetcher = NetworkDataFetcher()
        /// Менеджер работы с UserDefaults
        let localDM = LocalDataManager()
        /// Менеджер выбора Layout Collection View (размера ячеек)
        let CVLayout = CollViewLayoutModule()
        let viewModel = AdvancedViewModel(router: router, fetcher: fetcher, localDM: localDM)
        let VC = AdvancedViewController(viewModel: viewModel, layout: CVLayout)
        return VC
    }
}
