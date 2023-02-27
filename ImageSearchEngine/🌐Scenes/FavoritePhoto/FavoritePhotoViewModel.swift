//
//  FavoritePhotoViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 15.02.2023.
//

import UIKit
// MARK: - FavoritePhoto ViewModel Protocol
protocol FavoritePhotoViewModelProtocol {
    
    var favoritePhotos: [Photo] { get }
    
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol
//    func detailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol
    func navigateToPhotoDetailScreen(index: Int) /// Переход на экран детальной информации фотографии
}

// MARK: - FavoritePhoto View Model
final class FavoritePhotoViewModel: FavoritePhotoViewModelProtocol {
    
    // Загрузка массива любимых фотографий из памяти UserDefaults
    var favoritePhotos: [Photo] {
            DataManager.shared.fetchPhotos()
    }
    
    private var router: FavoriteRouterProtocol
    
    init(router: FavoriteRouterProtocol) {
        self.router = router
//        self.networkDataFetcher = fetcher
    }
    
    /// Передача данных фотографии для каждой отдельной ячейки
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol {
        let photo = favoritePhotos[indexPath.row]
        let isFavorite = favoritePhotos.contains(photo)
        return PhotoCellViewModel(photo: photo, isFavorite: isFavorite)
    }
    
//    /// Передача данных фотографии на экран детальной информации
//    func detailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol {
//        let photo = favoritePhotos[indexPath.row]
//        return DetailsViewModel(photo: photo)
//    }
    
    /// Переход на экран детальной информации фотографии через роутер
    func navigateToPhotoDetailScreen(index: Int) {
        let photo = favoritePhotos[index]
        router.routeToDetail(photo: photo)
    }
}
