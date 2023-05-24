//
//  ImageDownloadService.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 07.02.2023.
//

import Foundation

// MARK: Протокол загрузки изображений из сети
protocol ImageDownloadProtocol {
    /// Получает данные изображения
    ///  - Parameters:
    ///   - url: url
    ///   - completion: захватывает данные / ошибку
    func fetchImage(url: URL, completion: @escaping (Result<Data, DataFetcherError>) -> Void)
}

// MARK: Сервис загрузки изображений
final class ImageDownloader {
    
    static let shared = ImageDownloader()
    private init() {}
}

// MARK: - ImageDownloadProtocol
extension ImageDownloader: ImageDownloadProtocol {
    func fetchImage(url: URL,
                    completion: @escaping (Result<Data, DataFetcherError>) -> Void) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                guard (200..<300) ~= httpResponse.statusCode else {
                    completion(.failure(.invalidResponseCode))
                    return
                }
            }

            guard let data = data,
                  error == nil else {
                completion(.failure(.dataLoadingError))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
