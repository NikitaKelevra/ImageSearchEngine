//
//  AdvancedViewControllerViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.12.2022.
//

import UIKit
// MARK: - AdvancedViewController Protocol
protocol AdvancedViewModelProtocol {
    
    var randomPhotos: [Photo] { get set }
    var favoritePhotos: [Photo] { get set }
    /// Получение данных продукции из REST API
    func fetchRandomPhotos(completion: @escaping() -> Void)

}

// MARK: - AdvancedViewController View Model
final class AdvancedViewModel: AdvancedViewModelProtocol {
    var randomPhotos: [Photo] = []
    var favoritePhotos: [Photo] = []
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    // Получение массива случайных фотографий
    func fetchRandomPhotos(completion: @escaping() -> Void) {
        self.networkDataFetcher.fetchRandomPhotos{ [weak self] (photos) in
            self?.randomPhotos = photos
            completion()
        }
    }
    
    
    
    
}
