//
//  FavoritePhotoViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 15.02.2023.
//

import UIKit

protocol FavoritePhotoViewModelProtocol {
    
    ///  Массив избранных/добавленных фотографий
    var favoritePhotos: [Photo] { get }
    
    /// Передача данных фотографии для отображении каждой ячейки
    ///  - Parameters:
    ///     - indexPath: индекс ячейки Collection View
    /// - Returns: возвращает заполненую вью модель ячейки фотографии
    func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModelProtocol
    
    /// Переход на экран детальной информации фотографии выбранной ячейки
    ///  - Parameters:
    ///     - index: порядковый номер ячейки Collection View
    func navigateToPhotoDetailScreen(index: Int) /// Переход на экран детальной информации фотографии
    
    /// Инициализатор вью модели с необходимыми сервисами
    init(router: AdvancedRouterProtocol, fetcher: NetworkDataFetcher, localDM: LocalDataManagerProtocol)
}

// MARK: - FavoritePhoto View Model
final class FavoritePhotoViewModel: FavoritePhotoViewModelProtocol {
    
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
        let photo = favoritePhotos[indexPath.row]
        let isFavorite = favoritePhotos.contains(photo)
        return PhotoCellViewModel(photo: photo,
                                  isFavorite: isFavorite,
                                  fetcher: networkDataFetcher,
                                  localDM: localDataManager)
    }
    
    func navigateToPhotoDetailScreen(index: Int) {
        let photo = self.favoritePhotos[index]
        router.routeToDetail(photo: photo)
    }
}
