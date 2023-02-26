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
        
        /// Менеджер для работы перехода на дрегие экраны
        let router = FavoriteRouter(navigationController: navigationController)
        /// Менеджер для работы с сетью
//        let fetcher = NetworkDataFetcher()
        
        let viewModel = FavoritePhotoViewModel(router: router)
        let VC = FavoritePhotoViewController(viewModel: viewModel)
        return VC
    }
}
