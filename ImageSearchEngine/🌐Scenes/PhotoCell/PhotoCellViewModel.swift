//
//  PhotoCellViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.01.2023.
//

import UIKit

// MARK: - Protocol PhotoCell
protocol PhotoCellViewModelProtocol {
    var authorName: String { get }
    var isFavorite: Bool { get }
    func changePhotoStatus()
     
    func getImage(completion: @escaping(UIImage) -> Void) /// Получение фотографии ячейки
    
    init(photo: Photo, isFavorite: Bool)
}

// MARK: - ViewModel PhotoCell
final class PhotoCellViewModel: PhotoCellViewModelProtocol {
    
    var authorName: String {
        photo.user.name
    }
    
    func changePhotoStatus() {
        LocalDataManager.shared.changeFavoriteStatus(at: photo)
    }
    
    var isFavorite: Bool
    
    private var photo: Photo
    private let networkDataFetcher = NetworkDataFetcher()
    
    init(photo: Photo, isFavorite: Bool) {
        self.photo = photo
        self.isFavorite = isFavorite
    }
    
    // Функция ассинхронной загрузки изображения ячейки
    func getImage(completion: @escaping(UIImage) -> Void) {
        networkDataFetcher.fetchPhotoImage(link: photo.urls["regular"]) { image in
            completion(image)
        }
    }
}
