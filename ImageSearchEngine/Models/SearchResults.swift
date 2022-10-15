//
//  SearchResults.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import Foundation

struct SearchResults: Codable, Hashable {
    let total: Int
    let results: [Photo]
}

struct Photo: Codable, Hashable {
    let id: String
    let createdAt: String
    let title: String?
    let likes: Int
    let description: String?
    let location: Location?
    let urls: [PhotoSize.RawValue:String]
    let user: UserInfo
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case title
        case likes
        case description
        case location
        case urls
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
// MARK: - UserInfo
struct UserInfo: Codable, Hashable  {
    let id: String
    let name: String
}


// MARK: - Location
struct Location: Codable, Hashable {
    let city, country: String?
    let position: Position?
}

// MARK: - Position
struct Position: Codable, Hashable {
    let latitude, longitude: Double?
}
