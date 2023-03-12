//
//  NetworkDataFetcher.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 12.10.2022.
//

import UIKit

// Сервис принимающий data, принятую с сервера
final class NetworkDataFetcher {
    
    private var networkService = NetworkService()
    private let imageDownloader = ImageDownloader.shared
    private let photoCount = 30 // The number of photos to return. (Default: 1; max: 30)
    
    // MARK: - Загрузка данных (массива случайных фотографий)
    func fetchRandomPhotos(completion: @escaping ([Photo]) -> ()) {
        networkService.fetchRandomPhotos(photoCount: photoCount, completion: { result in
            switch result {
            case .failure(let error):
                print(DataFetcherError.dataLoadingError)
                print(error)
                completion([])
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        })
    }
    
    // MARK: - Загрузка маccива фотографий по поисковому запросу
    func fetchSearchPhotos(searchTerm: String, completion: @escaping ([Photo]) -> ()) {
        networkService.fetchSearchRequest(searchTerm: searchTerm) { result in
            switch result {
            case .failure(let error):
                print(DataFetcherError.dataLoadingError)
                print(error)
                completion([])
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.results)
                }
            }
        }
    }
    
    // MARK: - Загрузка маccива фотографий по поисковому запросу
    func fetchPhotoImage(link: String?, completion: @escaping (UIImage) -> ()) {
        guard let link = link,
              let url = URL(string: link) else {
            print(DataFetcherError.invalidUrl)
            return
        }        
        imageDownloader.fetchImage(url: url) { result in
            switch result {
            case .failure(let error):
                print(DataFetcherError.dataLoadingError)
                print(error)
            case .success(let data):
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else {
                        print(DataFetcherError.imageLoadingError)
                        return
                    }
                    completion(image)
                }
            }
        }
        
        
    }
}

extension NetworkDataFetcher {
    
    
}
