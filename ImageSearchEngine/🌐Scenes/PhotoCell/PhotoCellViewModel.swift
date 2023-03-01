//
//  PhotoCellViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.01.2023.
//

import UIKit

protocol PhotoCellViewModelProtocol {
    
    /// Имя автора фотографии
    var authorName: String { get }
    
    /// Отметка/статус - фотография в избранных(отмечена лайком) или нет
    var isFavorite: Bool { get }
    
    /// Изменить статус фотографии - поставить/убрать лайк
    func changePhotoStatus()
     
    /// Функция ассинхронной загрузки изображения ячейки
    ///  - Parameters:
    ///   - completion: захватывает фотографию / ошибку
    func getImage(completion: @escaping(UIImage) -> Void) /// Получение фотографии ячейки
    
    /// Инициализатор вью модели с необходимыми сервисами
    init(photo: Photo, isFavorite: Bool, fetcher: NetworkDataFetcher, localDM: LocalDataManagerProtocol)
}

// MARK: - ViewModel PhotoCell
final class PhotoCellViewModel: PhotoCellViewModelProtocol {
    
    var authorName: String {
        photo.user.name
    }
    
    var isFavorite: Bool
    
    private var photo: Photo
    private var networkDataFetcher: NetworkDataFetcher
    private var localDataManager: LocalDataManagerProtocol
    
    init(photo: Photo, isFavorite: Bool, fetcher: NetworkDataFetcher, localDM: LocalDataManagerProtocol) {
        self.photo = photo
        self.isFavorite = isFavorite
        self.networkDataFetcher = fetcher
        self.localDataManager = localDM
    }
    
    func changePhotoStatus() {
        localDataManager.changeFavoriteStatus(at: photo)
    }
    
    func getImage(completion: @escaping(UIImage) -> Void) {
        networkDataFetcher.fetchPhotoImage(link: photo.urls["regular"]) { image in
            completion(image)
        }
    }
}
