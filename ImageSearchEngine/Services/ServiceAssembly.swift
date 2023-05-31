//
//  ServiceAssembly.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 30.05.2023.
//

import Foundation

/// Класс для сборки зависимостей в сервисы
final class ServiceAssembly {
    /// Сервис для работы с хранилищем Keychain
    lazy var keychainStorageService: IKeychainStorageService = {
        return KeychainStorageService.shared
    }()
}
