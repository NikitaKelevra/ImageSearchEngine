//
//  DetailsViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.01.2023.
//

import UIKit
// MARK: - DetailsViewModel Protocol
protocol DetailsViewModelProtocol {
    
    var imageData: Data? { get }
    var authorNameLabel: String? { get }
    var creationDataLabel: String? { get }
    var photoLocationLabel: String? { get }
    var photoDownloadCount: String? { get }
    
    init(photo: Photo)
}


// MARK: - DetailsVC View Model
final class DetailsViewModel: DetailsViewModelProtocol {
    
    var imageData: Data? {
        networkDataFetcher.downloadedFrom(link: photo.urls["regular"])
    }
    
    var authorNameLabel: String? {
        "Author: \(photo.user.name)"
    }
    
    var creationDataLabel: String? {
        "Creation at: \(photo.createdAt)"
    }
    
    var photoLocationLabel: String? {
        "Location: \(String(describing: photo.location?.city))"
    }
    
    var photoDownloadCount: String? {
        "Download count: \(String(photo.likes))"
    }
    
    private let photo: Photo
    private var networkDataFetcher = NetworkDataFetcher()
    init(photo: Photo) {
        self.photo = photo
    }
    
    
}
