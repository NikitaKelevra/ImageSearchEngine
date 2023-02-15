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
    
    func getRandomPhotos(completion: @escaping() -> Void) /// Получение данных из REST API
    func getSearchPhotos(searchTerm: String, completion: @escaping() -> Void) /// Получение массива фотографий по поисковому запросу
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol /// Передача данных фотографии для отображении каждой ячейки
    func detailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol /// Передача данных фотографии на экран детальной информации
}

// MARK: - AdvancedViewController View Model
final class AdvancedViewModel: AdvancedViewModelProtocol {
    
    var photos: [Photo] = []
    
    var favoritePhotos: [Photo] {
            DataManager.shared.fetchPhotos()
    }
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    /// Передача данных фотографии для каждой отдельной ячейки
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol {
        let photo = photos[indexPath.row]
        let isFavorite = favoritePhotos.contains(photo)
        return PhotoCellViewModel(photo: photo, isFavorite: isFavorite)
    }
    
    /// Передача данных фотографии на экран детальной информации
    func detailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol {
        let photo = photos[indexPath.row]
        return DetailsViewModel(photo: photo)
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
}
