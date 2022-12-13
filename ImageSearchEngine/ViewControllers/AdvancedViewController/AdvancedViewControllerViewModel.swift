//
//  AdvancedViewControllerViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.12.2022.
//

import UIKit
// MARK: - AdvancedViewController Protocol
protocol AdvancedVCViewModelProtocol {
    
    
    // Получение данных продукции из REST API
    func fetchRandomPhotos() -> [Photo]
}

// MARK: - AdvancedViewController View Model
final class AdvancedViewControllerViewModel: AdvancedVCViewModelProtocol {
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    func fetchRandomPhotos() -> [Photo] {
        self.networkDataFetcher.fetchRandomImages{ [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            return fetchedPhotos
        }
    }
    
    
    
    
}
