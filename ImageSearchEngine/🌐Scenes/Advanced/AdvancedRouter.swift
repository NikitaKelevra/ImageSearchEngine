//
//  AdvancedRouter.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.02.2023.
//

import UIKit

// Протокол управления слоем навигации модуля DetailsViewModelProtocol
protocol AdvancedRouterProtocol {
    
    /// Получение массива фотографий по поисковому запросу
    ///  - Parameters:
    ///     - photo: выбраная фотография
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
        let detailsVC = DetailsModuleAssembly(photo: photo).createModule()
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
