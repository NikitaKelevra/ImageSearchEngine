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
    var photoImageView: Data? { get }
    var isFavorite: Bool { get }
    
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


class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from link: String) -> Data? {
        guard let url = URL(string: link) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
