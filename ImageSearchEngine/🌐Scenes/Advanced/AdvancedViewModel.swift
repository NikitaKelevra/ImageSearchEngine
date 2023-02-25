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
    func navigateToPhotoDetailScreen(index: Int) /// Переход на экран детальной информации фотографии
    
    init(router: AdvancedRouterProtocol,
         fetcher: NetworkDataFetcher)
}

// MARK: - AdvancedViewController View Model
final class AdvancedViewModel: AdvancedViewModelProtocol {
    
    var photos: [Photo] = []
    
    var favoritePhotos: [Photo] {
            DataManager.shared.fetchPhotos()
    }
    
    private var router: AdvancedRouterProtocol
    private var networkDataFetcher: NetworkDataFetcher
    
    
    init(router: AdvancedRouterProtocol, fetcher: NetworkDataFetcher) {
        self.router = router
        self.networkDataFetcher = fetcher
    }
    
    /// Передача данных фотографии для каждой отдельной ячейки
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
    
    /// Переход на экран детальной информации фотографии через протокол роутера
    func navigateToPhotoDetailScreen(index: Int) {
        let photo = self.photos[index]
        let detailsViewModel = DetailsViewModel(photo: photo)
        router.routeToDetail(viewModel: detailsViewModel)
    }
}
