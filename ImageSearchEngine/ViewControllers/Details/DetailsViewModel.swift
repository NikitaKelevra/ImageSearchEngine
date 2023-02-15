//
//  DetailsViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.01.2023.
//

import UIKit

// MARK: - DetailsViewModel Protocol
protocol DetailsViewModelProtocol {
    var authorNameLabel: String? { get }
    var creationDataLabel: String? { get }
    var photoLocationLabel: String? { get }
    var photoDownloadCount: String? { get }
    
    func getImage(completion: @escaping(UIImage) -> Void) /// Получение фотографии ячейки
    
    init(photo: Photo)
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
    private let networkDataFetcher = NetworkDataFetcher()
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func getImage(completion: @escaping(UIImage) -> Void) {
        networkDataFetcher.fetchPhotoImage(link: photo.urls["regular"]) { image in
            completion(image)
        }
    }
    
}
