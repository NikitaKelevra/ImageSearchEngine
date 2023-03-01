//
//  FavoritePhotoAssembly.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

// Favorite Module предназначен для создания модуля Favorite Photos
final class FavoriteModuleAssembly {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Assemblying
extension FavoriteModuleAssembly: Assemblying {
    func createModule() -> UIViewController {
        /// Менеджер перехода на другие экраны
        let router = AdvancedRouter(navigationController: navigationController)
        /// Менеджер для работы с сетью
        let fetcher = NetworkDataFetcher()
        /// Менеджер работы с UserDefaults
        let localDM = LocalDataManager()
        /// Менеджер выбора Layout Collection View (размера ячеек)
        let CVLayout = CollViewLayoutModule()
        let viewModel = FavoritePhotoViewModel(router: router, fetcher: fetcher, localDM: localDM)
        let VC = FavoritePhotoViewController(viewModel: viewModel, layout: CVLayout)
        return VC
    }
}
