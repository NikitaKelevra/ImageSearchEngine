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
    ///  - Parameter model: модель фотографии
    func routeToDetail(viewModel: DetailsViewModel)
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

    func routeToDetail(viewModel: DetailsViewModel) {
        let detailsVC = DetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
