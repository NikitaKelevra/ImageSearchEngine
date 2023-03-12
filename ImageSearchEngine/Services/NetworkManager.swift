//
//  NetworkManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.03.2023.
//

import Foundation
import Combine

// Сервис делающий запрос информации на сервере
final class NetworkManager {
    
    private let accessKey = "F4j3Eu0xH5CIds0eXdq2ARPIUfmjDnUbKKw4r3JgXVw"
    
    
    // MARK: - Запрос данных - массива фотографий по поисковому запросу
    func fetchPhotos(for searchTerm: String) -> AnyPublisher<[Photo], Never> {
        
        /// Формируем запрос на сервер на основе поискового запроса
        let parameters = self.prepareParaments(searchTerm: searchTerm)
        let url = self.searchURL(params: parameters)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.method = .get
        print(request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: PhotoResponse.self, decoder: JSONDecoder())
            .map {$0.results}
            .catch { error in Just([])}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    
    
    
    
    private func prepareParaments(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func searchURL(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    // Подготовка заголовка с ключом авторизации
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID \(accessKey)"
        return headers
    }
    
}
