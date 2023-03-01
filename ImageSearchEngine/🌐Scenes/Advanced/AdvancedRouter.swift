//
//  AdvancedRouter.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.02.2023.
//

import UIKit

// Протокол управления слоем навигации модуля Details ViewModel 
protocol AdvancedRouterProtocol {
    
    /// Переход к экрану детальной информации
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

// MARK: - AdvancedRouterProtocol
extension AdvancedRouter: AdvancedRouterProtocol {
    /// Переход к экрану детальной информации конкретной фотографии
    func routeToDetail(photo: Photo) {
        let detailsVC = DetailsModuleAssembly(photo: photo).createModule()
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
