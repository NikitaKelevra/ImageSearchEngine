//
//  AdvancedRouter.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.02.2023.
//

import UIKit

// MARK: - Advanced Routing Protocol
// Протокол управления слоем навигации модуля DetailsViewModelProtocol
protocol AdvancedRouterProtocol {
    /// Переход к экрану детальной информации
    ///  - Parameter photo: выбраная фотография
    func routeToDetail(photo: Photo)
}

// MARK: - Advanced Router
// Слой навигации модуля Advanced
final class AdvancedRouter {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - RecipeListRouting
extension AdvancedRouter: AdvancedRouterProtocol {
    /// Переход к экрану детальной информации конкретной фотографии
    func routeToDetail(photo: Photo) {
//        guard let navigationController = navigationController else { return }
        let detailsVC = DetailsModuleAssembly(photo: photo).createModule()
        
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
