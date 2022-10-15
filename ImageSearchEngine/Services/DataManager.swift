//
//  DataManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 15.10.2022.
//

import Foundation

class DataManager {
    // MARK: - Property
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let favPhotosKey = "newPhotosList"
    
    private init() {}
    
    // MARK: - Function
    /// Добавление/удаление элемента в массиве `Favorite Photos`
    func changeFavoriteStatus(at photo: Photo) {
        var channels = fetchPhotos()
        if let index = channels.firstIndex(of: photo) {
            channels.remove(at: index)
        } else {
            channels.append(photo)
        }
        saveFavoritePhotosArray(favPhotos: channels)
    }
    /// Изменение места расположения элемента в массиве `Favorite Photos`
    func changePlaceInFavArray(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        var photos = fetchPhotos()
        let photo = photos[sourceIndexPath.row]
        photos.remove(at: sourceIndexPath.row)
        photos.insert(photo, at: destinationIndexPath.row)
        saveFavoritePhotosArray(favPhotos: photos)
    }
    /// Выгрузка массива `Favorite Photos`
    func fetchPhotos() -> [Photo] {
        guard let data = userDefaults.object(forKey: favPhotosKey) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([Photo].self, from: data) else { return [] }
        return contacts
    }
    /// Сохранение массива `Favorite Photos`
    private func saveFavoritePhotosArray(favPhotos: [Photo]) {
        guard let data = try? JSONEncoder().encode(favPhotos) else { return }
        userDefaults.set(data, forKey: favPhotosKey)
    }
}
