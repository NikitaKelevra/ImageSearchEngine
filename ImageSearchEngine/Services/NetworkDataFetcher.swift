//
//  NetworkDataFetcher.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 12.10.2022.
//

import UIKit

class NetworkDataFetcher {
    
    private var networkService = NetworkService()
    private let photoCount = 30 // The number of photos to return. (Default: 1; max: 30)
    
    // MARK: - Загрузка данных (случайных фотографий)
    func fetchRandomPhotos(completion: @escaping ([Photo]) -> ()) {
        networkService.fetchRandomPhotos(photoCount: photoCount, completion: { result in
            switch result {
            case .failure(let error):
                print("ОШИБКА ИЗВЛЕЧЕНИЯ NetworkDataFetcher")
                print(error)
                completion([])
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response)
//                    print(response)
                }
            }
        })
    }
    
    // MARK: - Загрузка картинок по запросу
    func fetchSearchImages(searchTerm: String, completion: @escaping (RandomPhotoResponse?) -> ()) {
        networkService.searchRequest(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }    
            let decode = self.decodeJSON(type: RandomPhotoResponse.self, from: data)
            completion(decode)
        }
    }
    
    // MARK: -
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
}
