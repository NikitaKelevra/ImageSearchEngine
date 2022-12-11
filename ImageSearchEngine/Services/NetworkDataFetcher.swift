//
//  NetworkDataFetcher.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 12.10.2022.
//

import UIKit

class NetworkDataFetcher {
    
    private var networkService = NetworkService()
    
    // MARK: - Загрузка случайных картинок
    func fetchRandomImages(completion: @escaping ([Photo]?) -> ()) {
        networkService.ramdomPhotoRequest{ (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: [Photo].self, from: data)
            completion(decode)
        }
    }
    
    // MARK: - Загрузка картинок по запросу
    func fetchSearchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.searchRequest(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }    
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
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
