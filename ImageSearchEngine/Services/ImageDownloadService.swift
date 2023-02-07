//
//  ImageDownloadService.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 07.02.2023.
//

import UIKit

/// #Сервис загрузки изображений
final class ImageDownloader {
    
    static let shared = ImageDownloader()
    private init() {}

    
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
    
    // MARK: - Загрузка фотографии по URL из String
    @available(iOS 15, *) // Swift 5.5 / iOS 15 / async\await
    func fetchImage(from stringUrl: String) async throws -> UIImage {

        
        guard let imageUrl = URL(string: stringUrl) else {
            throw DataFetcherError.invalidUrl
        }
        
        let session = URLSession.shared
        
        let (data, response) = try await session.data(from: imageUrl)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DataFetcherError.dataLoadingError
        }
        
        guard let image = UIImage(data: data) else {
            return UIImage()
        }
        
        return image
    }
    
    
}


//        if let url = URL(string: stringUrl) {
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//              // Error handling...
//              guard let imageData = data else { return }
//
//              DispatchQueue.main.async {
//                self.image = UIImage(data: imageData)
//                  let image = UIImage(data: imageData)
//                  return image
//              }
//            }.resume()
//



//func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        if let data = data, let img = UIImage(data: data) {
//            completion(img)
//        } else {
//            completion(nil)
//        }
//    }.resume()
//}


//func setImageFromStringrURL(stringUrl: String) {
//  if let url = URL(fromString: stringUrl) {
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//      // Error handling...
//      guard let imageData = data else { return }
//
//      DispatchQueue.main.async {
//        self.image = UIImage(data: imageData)
//      }
//    }.resume()
//  }
//}
