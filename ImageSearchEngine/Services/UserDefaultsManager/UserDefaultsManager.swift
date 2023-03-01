//
//  UserDefaultsManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import Foundation

// MARK: - Протокол проверки готовности пользователя
protocol UserDefaultsVerifable {
    func checkReady() -> Bool
}

// MARK: - Сервис работы с UserDefaults
final class UserDefaultsManager {

    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    private init() {}
}

// MARK: - UserDefaultsVerifable
extension UserDefaultsManager: UserDefaultsVerifable {
    func checkReady() -> Bool {
        UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserReady.rawValue)
    }
}
