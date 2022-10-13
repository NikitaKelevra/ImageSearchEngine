//
//  NetworkService.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import Foundation


class NetworkService {
    private let accessKey = "F4j3Eu0xH5CIds0eXdq2ARPIUfmjDnUbKKw4r3JgXVw"
    
    /// Построение запроса случайных фотографий
    func ramdomPhotoRequest(completion: @escaping (Data?, Error?) -> Void)  {
        let parameters = self.prepareParaments()
        let url = self.urlRandomImage(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    /// Построение запроса фотографий по вводимым данным
    func searchRequest(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
        let parameters = self.prepareParaments(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID \(accessKey)"
        return headers
    }
    
    private func prepareParaments(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    
    
    private func prepareParaments() -> [String: String] {
        var parameters = [String: String]()
        parameters["count"] = String(30)
        return parameters
    }
    
    private func urlRandomImage(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
}

