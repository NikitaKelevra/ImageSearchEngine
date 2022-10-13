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
    
//    static func == (lhs: Photo, rhs: Photo) -> Bool {
//       return lhs.id == rhs.id
//    }
    
    let id: String
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    
    
    enum URLKing: String, Hashable {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
