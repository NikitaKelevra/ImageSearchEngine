//
//  AccountModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 14.05.2023.
//

import Foundation

/// Модель персональных данных пользователя
struct PersonalInfo: Equatable {
    var isDarkMode: Bool
}

/// Модель пользовательских настроек
struct AccountSettings: Equatable {
    var nickname: String
    var name: String
    var email: String
}

/// Модель аккаунта пользователя
struct AccountModel: Equatable {
    var id: Int
    
    
    var personalInfo: PersonalInfo

    var favoritesPhoto: [Photo]     /// Массив избранных фотографий пользователя

    var settings: AccountSettings
    

}

// MARK: - Equatable
extension AccountModel: Equatable {
    static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.personalInfo == rhs.personalInfo &&
        lhs.favoritesPhoto == rhs.favoritesPhoto &&
        lhs.settings == rhs.settings
    }
}
