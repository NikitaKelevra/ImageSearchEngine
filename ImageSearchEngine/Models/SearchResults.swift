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
    let title: String?
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    let user: User
    
    
    enum URLKing: String, Hashable {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct User: Codable, Hashable  {
    let id: String
    let name: String
}
