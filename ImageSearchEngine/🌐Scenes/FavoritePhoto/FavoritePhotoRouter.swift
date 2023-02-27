//
//  FavoritePhotoRouter.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

// MARK: - AdvancedRouting Protocol
// Протокол управления слоем навигации модуля DetailsViewModelProtocol
protocol FavoriteRouterProtocol {
    /// Переход к экрану детальной информации
    ///  - Parameter photo: выбраная фотография
    func routeToDetail(photo: Photo)
}

// MARK: - FavoriteRouter
// Слой навигации модуля Favorite
final class FavoriteRouter {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - RecipeListRouting
extension FavoriteRouter: FavoriteRouterProtocol {
    /// Переход к экрану детальной информации конкретной фотографии
    func routeToDetail(photo: Photo) {
//        guard let navigationController = navigationController else { return }
        let detailsVC = DetailsModuleAssembly(photo: photo).createModule()
        UINavigationController().pushViewController(detailsVC, animated: true)
    }
}
