//
//  ImageManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 27.01.2023.
//

import UIKit

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    @available(iOS 13, *)
    func fetchImage(from stringUrl: String) async throws -> UIImage {

        guard let url = URL(string: stringUrl) else { return UIImage() }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw fatalError() }
        guard let image = UIImage(data: data) else { return UIImage() }
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
