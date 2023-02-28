//
//  AdvancedViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.12.2022.
//

import UIKit

// MARK: - AdvancedViewController Protocol
protocol AdvancedViewModelProtocol {
    
    /// Основной массив фотографий Collection View
    var photos: [Photo] { get set }
    
    ///  Массив избранных/добавленных фотографий
    var favoritePhotos: [Photo] { get }
    
    /// Получение массива рандомных фотографий
    ///  - Parameters:
    ///   - completion: захватывает массив фотографий / ошибку
    func getRandomPhotos(completion: @escaping() -> Void)
    
    /// Получение массива фотографий по поисковому запросу
    ///  - Parameters:
    ///     - searchTerm: поисковый запрос пользователя
    ///     - completion: захватывает массив фотографий / ошибку
    func getSearchPhotos(searchTerm: String, completion: @escaping() -> Void)
    
    /// Передача данных фотографии для отображении каждой ячейки
    ///  - Parameters:
    ///     - indexPath: индекс ячейки Collection View
    /// - Returns: возвращает заполненую вью модель ячейки фотографии
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol
    
    /// Переход на экран детальной информации фотографии выбранной ячейки
    ///  - Parameters:
    ///     - index: порядковый номер ячейки Collection View
    func navigateToPhotoDetailScreen(index: Int)
    
    /// Инициализатор вью модели с необходимыми сервисами
    init(router: AdvancedRouterProtocol, fetcher: NetworkDataFetcher, localDM: LocalDataManagerProtocol)
}

// MARK: - AdvancedViewController View Model
final class AdvancedViewModel: AdvancedViewModelProtocol {
    
    var photos: [Photo] = []
    var favoritePhotos: [Photo] {
        localDataManager.fetchPhotos()
    }
    
    private var router: AdvancedRouterProtocol
    private var networkDataFetcher: NetworkDataFetcher
    private var localDataManager: LocalDataManagerProtocol
    
    init(router: AdvancedRouterProtocol,
         fetcher: NetworkDataFetcher,
         localDM: LocalDataManagerProtocol) {
        self.router = router
        self.networkDataFetcher = fetcher
        self.localDataManager = localDM
    }
    
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol {
        let photo = photos[indexPath.row]
        let isFavorite = favoritePhotos.contains(photo)
        return PhotoCellViewModel(photo: photo, isFavorite: isFavorite)
    }
    
    func getRandomPhotos(completion: @escaping() -> Void) {
        self.networkDataFetcher.fetchRandomPhotos{ [weak self] (photos) in
            self?.photos = photos
            completion()
        }
    }
    
    func getSearchPhotos(searchTerm: String, completion: @escaping() -> Void) {
        self.networkDataFetcher.fetchSearchPhotos(searchTerm: searchTerm,
                                                  completion: { [weak self] (photos) in
            self?.photos = photos
            completion()
        })
    }
    
    func navigateToPhotoDetailScreen(index: Int) {
        let photo = self.photos[index]
        router.routeToDetail(photo: photo)
    }
}
