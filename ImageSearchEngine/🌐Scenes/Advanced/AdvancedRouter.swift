//
//  AdvancedRouter.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.02.2023.
//

import UIKit

// MARK: - AdvancedRouting Protocol
// Протокол управления слоем навигации модуля DetailsViewModelProtocol
protocol AdvancedRouterProtocol {
    /// Переход к экрану детальной информации
    ///  - Parameter model: модель фотографии
    func routeToDetail(viewModel: DetailsViewModel)
}

// MARK: - AdvancedRouter
// Слой навигации модуля Advanced
final class AdvancedRouter {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - RecipeListRouting
extension AdvancedRouter: AdvancedRouterProtocol {

    func routeToDetail(viewModel: DetailsViewModel) {
        let detailsVC = DetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
