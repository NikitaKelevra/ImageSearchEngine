//
//  ImageManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 27.01.2023.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from link: String) -> Data? {
        guard let url = URL(string: link) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
