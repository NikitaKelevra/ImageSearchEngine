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
                }
            }
        })
    }
    
    // MARK: - Загрузка картинок по запросу
    func fetchSearchPhotos(searchTerm: String, completion: @escaping ([Photo]) -> ()) {
        networkService.fetchSearchRequest(searchTerm: searchTerm) { result in
            switch result {
            case .failure(let error):
                print("ОШИБКА ИЗВЛЕЧЕНИЯ NetworkDataFetcher")
                print(error)
                completion([])
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.results)
                    print(response)
                }
            }
        }
    }
}
