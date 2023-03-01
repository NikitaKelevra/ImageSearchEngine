//
//  DetailsModuleAssembly.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 26.02.2023.
//

import UIKit

// Details Module Assembly предназначен для создания модуля Details View Controller
final class DetailsModuleAssembly {
    private let photo: Photo

    init(photo: Photo) {
        self.photo = photo
    }
}

// MARK: - Assemblying
extension DetailsModuleAssembly: Assemblying {
    func createModule() -> UIViewController {
        /// Менеджер для работы с сетью
        let fetcher = NetworkDataFetcher()
        let viewModel = DetailsViewModel(photo: photo, fetcher: fetcher)
        let VC = DetailsViewController(viewModel: viewModel)
        return VC
    }
}
