//
//  PhotoResponse.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 21.12.2022.
//

import Foundation

// MARK: - PhotoResponse
struct PhotoResponse: Codable, Hashable {
    let total: Int
    let results: [Photo]
}
// MARK: - Модель изображения
struct Photo: Codable, Hashable {
    let id: String
    let createdAt: String // Date
    let title: String?
    let urls: [PhotoSize.RawValue:String]
    let links: RandomPhotoResponseLinks
    let likes: Int
    let description: String?
    let location: Location?
    let user: UserInfo
    var isFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case title
        case urls
        case links
        case likes
        case description
        case location
        case user
    }
}

enum PhotoSize: String, Codable, Hashable {
    case raw
    case full
    case regular
    case small
    case thumb
}
// MARK: - Модель автора изображения
struct UserInfo: Codable, Hashable  {
    let id: String
    let name: String
}

// MARK: - Модель локации изображения
struct Location: Codable, Hashable {
    let city, country: String?
    let position: Position?
}

// MARK: - Position
struct Position: Codable, Hashable {
    let latitude, longitude: Double?
}

// MARK: - Links
struct RandomPhotoResponseLinks: Codable, Hashable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}
