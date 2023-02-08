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
    var imageData: Data? { get }
    var isFavorite: Bool { get }
    func changePhotoStatus()
     
    init(photo: Photo, isFavorite: Bool)
}

// MARK: - ViewModel PhotoCell
final class PhotoCellViewModel: PhotoCellViewModelProtocol {
    
    var imageData: Data? {
        networkDataFetcher.downloadedFrom(link: photo.urls["regular"])
    }
    
    var authorName: String {
        photo.user.name
    }
    
    func changePhotoStatus() {
        DataManager.shared.changeFavoriteStatus(at: photo)
    }
    
    var isFavorite: Bool
    
    private let photo: Photo
    private var networkDataFetcher = NetworkDataFetcher()
    
    init(photo: Photo, isFavorite: Bool) {
        self.photo = photo
        self.isFavorite = isFavorite
    }
}
