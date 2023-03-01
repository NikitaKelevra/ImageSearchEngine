//
//  DetailsViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.01.2023.
//

import UIKit

protocol DetailsViewModelProtocol {
    
    /// Имя автора фотографии
    var authorNameLabel: String? { get }
    
    /// Дата создания фотографии
    var creationDataLabel: String? { get }
    
    /// Место создания фотографии
    var photoLocationLabel: String? { get }
    
    /// Количество скачиваний фотографии
    var photoDownloadCount: String? { get }
    
    /// Функция ассинхронной загрузки изображения ячейки
    ///  - Parameters:
    ///   - completion: захватывает фотографию / ошибку
    func getImage(completion: @escaping(UIImage) -> Void)
    
    /// Инициализатор вью модели с необходимыми сервисами
    init(photo: Photo, fetcher: NetworkDataFetcher)
}

// MARK: - DetailsVC View Model
final class DetailsViewModel: DetailsViewModelProtocol {
    
    var authorNameLabel: String? {
        photo.user.name
    }
    
    var creationDataLabel: String? {
        photo.createdAt
    }
    
    var photoLocationLabel: String? {
        photo.location?.city
    }
    
    var photoDownloadCount: String? {
        String(photo.likes)
    }
    
    private let photo: Photo
    private let fetcher: NetworkDataFetcher
    
    init(photo: Photo, fetcher: NetworkDataFetcher) {
        self.photo = photo
        self.fetcher = fetcher
    }
    
    func getImage(completion: @escaping(UIImage) -> Void) {
        fetcher.fetchPhotoImage(link: photo.urls["regular"]) { image in
            completion(image)
        }
    }
    
}
