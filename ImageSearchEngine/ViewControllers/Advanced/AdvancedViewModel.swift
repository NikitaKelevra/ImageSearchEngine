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
    var favoritePhotos: [Photo] { get }
    
    var layoutType: Int { get set }
    
    func getRandomPhotos(completion: @escaping() -> Void) /// Получение данных продукции из REST API
    func getSearchPhotos(searchTerm: String, completion: @escaping() -> Void) /// Получение массива фотографий по поисковому запросу
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol
}

// MARK: - AdvancedViewController View Model
final class AdvancedViewModel: AdvancedViewModelProtocol {
    var photos: [Photo] = []
    var favoritePhotos: [Photo] {
            DataManager.shared.fetchPhotos()
    }
    
    private var defaultLayoutType = 1
    var layoutType: Int {
        get {
            defaultLayoutType
        }
        set (newLayoutType) {
            if newLayoutType > 3 {
                self.defaultLayoutType = 1
            }
            print(" defaultLayoutType --- \(layoutType)")
        }
    }
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    // MARK: -
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol {
        let photo = photos[indexPath.row]
        let isFavorite = favoritePhotos.contains(photo)
        return PhotoCellViewModel(photo: photo, isFavorite: isFavorite)
    }
    
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
    
    // MARK: -
    
    
}
