//
//  DataManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 15.10.2022.
//

import Foundation


protocol LocalDataManagerProtocol {
    
    /// Добавление/удаление элемента в массиве `Favorite Photos`
    ///  - Parameters:
    ///     - photo: фотография, у когорой нужно изменить статус favorite
    func changeFavoriteStatus(at photo: Photo)
    
    /// Выгрузка массива `Favorite Photos`
    /// - Returns: Массив Favorite Photos
    func fetchPhotos() -> [Photo]
    
    /// Изменение места расположения элемента в массиве `Favorite Photos`
    ///  - Parameters:
    ///     - sourceIndexPath: изначальный IndexPath ячейки
    ///     - destinationIndexPath: конечный IndexPath ячейки
    func changePlaceInFavArray(sourceIndexPath: IndexPath,
                               destinationIndexPath: IndexPath)
}

// Сервис работы с UserDefaults
final class LocalDataManager {
    
    private let userDefaults = UserDefaults.standard
    private let favPhotosKey = UserDefaultsKeys.favoritePhotosKey.rawValue
//    static let shared = LocalDataManager()
}

// MARK: - LocalDataManagerProtocol
extension LocalDataManager: LocalDataManagerProtocol {
    
    func changeFavoriteStatus(at photo: Photo) {
        var channels = fetchPhotos()
        if let index = channels.firstIndex(of: photo) {
            channels.remove(at: index)
        } else {
            channels.append(photo)
        }
        saveFavoritePhotosArray(favPhotos: channels)
        
    }

    func fetchPhotos() -> [Photo] {
        guard let data = userDefaults.object(forKey: favPhotosKey) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([Photo].self, from: data) else { return [] }
        return contacts
    }
    
    func changePlaceInFavArray(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        var photos = fetchPhotos()
        let photo = photos[sourceIndexPath.row]
        photos.remove(at: sourceIndexPath.row)
        photos.insert(photo, at: destinationIndexPath.row)
        saveFavoritePhotosArray(favPhotos: photos)
    }
    
    /// Сохранение массива `Favorite Photos`
    private func saveFavoritePhotosArray(favPhotos: [Photo]) {
        guard let data = try? JSONEncoder().encode(favPhotos) else { return }
        userDefaults.set(data, forKey: favPhotosKey)
    }
}
