//
//  PhotoCellViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.01.2023.
//

import UIKit
import SDWebImage

// MARK: - Protocol
protocol PhotoCellViewModelProtocol {
    var isFavorite: Bool { get }
    var photoImageView: Data? { get }
    
    init(photo: Photo, isFavorite: Bool)
    
}


// MARK: - View Model
final class PhotoCellViewModel: PhotoCellViewModelProtocol {
    
    var photoImageView: Data? {
        ImageManager.shared.fetchImageData(from: photo.urls["regular"] ?? "")
//        photoImageView.downloadedFrom(link: photo.urls["regular"])
    }
    
    var isFavorite: Bool
    
    private let photo: Photo
    
    init(photo: Photo, isFavorite: Bool) {
        self.photo = photo
        self.isFavorite = isFavorite
    }
    

}
