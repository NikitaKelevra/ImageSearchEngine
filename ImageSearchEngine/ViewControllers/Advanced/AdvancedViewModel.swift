//
//  AdvancedViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.12.2022.
//

import UIKit
// MARK: - AdvancedViewController Protocol
protocol AdvancedViewModelProtocol {
    
    var photos: [Photo] { get set }
    var favoritePhotos: [Photo] { get set }
    
    
    func getRandomPhotos(completion: @escaping() -> Void) /// Получение данных продукции из REST API
    func getSearchPhotos(searchTerm: String, completion: @escaping() -> Void) /// Получение массива фотографий по поисковому запросу
}

// MARK: - AdvancedViewController View Model
final class AdvancedViewModel: AdvancedViewModelProtocol {
    var photos: [Photo] = []
    var favoritePhotos: [Photo] = []
    private var networkDataFetcher = NetworkDataFetcher()
    
    // Получение массива случайных фотографий
    func getRandomPhotos(completion: @escaping() -> Void) {
        self.networkDataFetcher.fetchRandomPhotos{ [weak self] (photos) in
            self?.photos = photos
            completion()
        }
    }
    
    // Получение массива фотографий по поисковому запросу
    func getSearchPhotos(searchTerm: String, completion: @escaping() -> Void) {
        self.networkDataFetcher.fetchSearchPhotos(searchTerm: searchTerm,
                                                  completion: { [weak self] (photos) in
            self?.photos = photos
            completion()
        })
    }
    
    
}
