//
//  NetworkService.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import Foundation
import Alamofire

// Варианты ошибок
enum ErrorDomain: Error {
    case AFError(AFError?)
    case errorGettingData
}

class NetworkService {

    typealias RandomResponseResult = (Result<[Photo], AFError>) -> Void
    typealias SearchResponseResult = (Result<PhotoResponse, AFError>) -> Void
    
    private let accessKey = "F4j3Eu0xH5CIds0eXdq2ARPIUfmjDnUbKKw4r3JgXVw"
    
    // MARK: - Запрос случайных фотографий
    func fetchRandomPhotos(photoCount: Int, completion: @escaping RandomResponseResult) {

        let parameters = self.prepareParaments(photoCount: photoCount)
        let url = self.getRandomImageURL(params: parameters)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.method = .get
//        print(request)
        
        performDecodableRequest(request: request, completion: completion)
    }
    
    // Подготовка параметров запроса (Request)
    private func prepareParaments(photoCount: Int) -> [String: String] {
        var parameters = [String: String]()
        parameters["count"] = String(photoCount)
        return parameters
    }
    // Создание запроса с учетов параметроов
    private func getRandomImageURL(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }

    // MARK: - Search Request
    
    /// Построение запроса фотографий по вводимым в поисковик данным
    func fetchSearchRequest(searchTerm: String, completion: @escaping SearchResponseResult) {
        let parameters = self.prepareParaments(searchTerm: searchTerm)
        let url = self.searchURL(params: parameters)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.method = .get
        print(request)
        
        performDecodableRequest(request: request, completion: completion)
    }
    
//    func searchRequest(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
//        let parameters = self.prepareParaments(searchTerm: searchTerm)
//        let url = self.searchURL(params: parameters)
//        var request = URLRequest(url: url)
//        request.allHTTPHeaderFields = prepareHeader()
//        request.httpMethod = "get"
//        let task = createDataTask(from: request, completion: completion)
//        task.resume()
//    }
    
    // Подготовка заголовка с ключом авторизации
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
    
    private func searchURL(params: [String: String]) -> URL {
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
}


// MARK: - Внутренние методы
extension NetworkService {
    // Создание запросов с загрузкой аватарки
    private func performDecodableUploadRequest<T: Decodable>(requestData: (MultipartFormData, URL),
                                                             completion: @escaping ((Result<T, AFError>) -> Void)) {
        let headers = [
            "Content-Type": "multipart/form-data",
            "Content-Disposition": "form-data"
        ]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let mfObject = requestData.0
        
        print(mfObject)
        
        AF
            .upload(multipartFormData: mfObject, to: requestData.1,
                    method: .post, headers: .init(headers))
            .validate()
            .responseDecodable(
                of: T.self,
                queue: .global(qos: .userInitiated),
                decoder: decoder
            ) { result in
                guard let data = result.value else {
                    if let error = result.error {
                        completion(.failure(error))
                    }
                    return
                }
                print(data)
                completion(.success(data))
                
            }
    }
    
    // Создание запроса без параметров
    private func performRequest<T: Decodable>(request: URLRequest , // RequestProvider
                                              completion: @escaping (Result<T, ErrorDomain>) -> Void) {
        //        let request = request.request
        AF.request(request).validate().responseDecodable(of: T.self , queue: .global(qos: .userInitiated)) { data in
            guard let data = data.value else {
                completion(.failure(.AFError(data.error)))
                return
            }
            completion(.success(data))
        }
    }
    
    // Создание запроса с приведением к типу Т
    private func performDecodableRequest<T: Decodable>(request: URLRequest,
                                                       completion: @escaping ((Result<T, AFError>) -> Void)) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        AF.request(request)
            .validate()
            .responseDecodable(
                of: T.self,
                queue: .global(qos: .userInitiated),
                decoder: decoder
            ) { result in
                guard let data = result.value else {
                    if let error = result.error {
                        print("ОШИБКА ИЗВЛЕЧЕНИЯ NetworkService")
                        print(error)
                        completion(.failure(error))
                    }
                    return
                }
                completion(.success(data))
            }
    }
    
}
