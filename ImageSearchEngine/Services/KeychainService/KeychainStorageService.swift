//
//  KeychainStorageService.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 30.05.2023.
//

import Foundation

/// Протокол для работы с хранилищем KeyChain
/// - На данный момент используются только методы CRUD
protocol IKeychainStorageService {
    /// Возможные ошибки при работе с хранилищем Keychain
    typealias ResultError = KeychainStorageService.KeychainError
    
    /// Метод для сохранения данных в защищенное хранилище.
    /// - Parameters:
    ///   - item: принимает любой тип который поддерживает Codable, который будет
    ///    преобразован в Data.
    ///   - service: принимает описание, что мы сохраняем, к примеру "access-token"
    ///   - account: принимает имя аккаунта. К примеру "ZyFun"
    ///   - completion: возвращает Result типа Void или ``KeychainError``.
    ///     - Result Void: данные успешно сохранены
    ///     - Result KeychainError: возвращает перечисление известных возможных ошибок.
    ///     Если ошибка неизвестна, в ассоциативном значении, возвращает ошибку типа
    ///     NSOSStatusErrorDomain.
    func save<T>(
        _ item: T,
        service: String,
        account: String,
        completion: (Result<Void, ResultError>) -> Void
    ) where T: Codable
    
    /// Метод для чтения данных из защищенного хранилища.
    /// - Parameters:
    ///   - typeData: Принимает тип данных, с которыми будет производится работа.
    ///   Данные должны быть Codable
    ///   - service: принимает описание, что мы пытаемся прочитать, к примеру "access-token"
    ///   - account: принимает имя аккаунта. К примеру "ZyFun"
    ///   - completion: возвращает Result типа Data или ``KeychainError``.
    ///     - Result data: сохраненные данные, которые были прочитаны из keychain
    ///     - Result KeychainError: возвращает перечисление известных возможных ошибок.
    ///     Если ошибка неизвестна, в ассоциативном значении, возвращает ошибку типа
    ///     NSOSStatusErrorDomain.
    func fetch(
        service: String,
        account: String,
        completion: (Result<String, ResultError>) -> Void
    )
    
    /// Метод для обновления данных в защищенном хранилище.
    /// - Parameters:
    ///   - item: принимает любой тип который поддерживает Codable, который будет
    ///    преобразован в Data.
    ///   - service: принимает описание, что мы обновляем, к примеру "access-token"
    ///   - account: принимает имя аккаунта. К примеру "ZyFun"
    ///   - completion: возвращает Result типа Void или ``KeychainError``.
    ///     - Result Void: данные успешно обновлены
    ///     - Result KeychainError: возвращает перечисление известных возможных ошибок.
    ///     Если ошибка неизвестна, в ассоциативном значении, возвращает ошибку типа
    ///     NSOSStatusErrorDomain.
    func update<T>(
        _ item: T,
        service: String,
        account: String,
        completion: (Result<Void, ResultError>) -> Void
    ) where T: Codable
    
    /// Метод для удаления данных из защищенного хранилища.
    /// - Parameters:
    ///   - service: принимает описание, что мы пытаемся удалить, к примеру "access-token"
    ///   - account: принимает название, от чего этот токен, к примеру "ZyFun"
    ///   - completion: возвращает Result типа Void или ``KeychainError``.
    ///     - Result Void: данные успешно удалены
    ///     - Result KeychainError: возвращает перечисление известных возможных ошибок.
    ///     Если ошибка неизвестна, в ассоциативном значении, возвращает ошибку типа
    ///     NSOSStatusErrorDomain.
    func delete(
        service: String,
        account: String,
        completion: (Result<Void, ResultError>) -> Void
    )
}

/// Класс для работы с keychain
final class KeychainStorageService: IKeychainStorageService {
    static let shared: IKeychainStorageService = KeychainStorageService()
    
    init() {}
    
    func save<T>(
        _ item: T,
        service: String,
        account: String,
        completion: (Result<Void, ResultError>) -> Void
    ) where T: Codable {
        var secData: Data
        do {
            secData = try JSONEncoder().encode(item)
        } catch {
            completion(.failure(.failedToEncodeToData))
            return
        }
        
        let query = [
            kSecValueData: secData,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        let error = NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        
        // Посмотреть коды ошибок можно тут https://www.osstatus.com
        switch status {
        case errSecSuccess:
            completion(.success(()))
        case errSecDuplicateItem:
            completion(.failure(.errSecDuplicateItem))
        default:
            completion(.failure(.unknownError(error)))
        }
    }
    
    func fetch(
        service: String,
        account: String,
        completion: (Result<String, ResultError>) -> Void
    ) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        let error = NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        
        // Посмотреть коды ошибок можно тут https://www.osstatus.com
        switch status {
        case errSecSuccess:
            if let data = result as? Data {
                do {
                  let item = try JSONDecoder().decode(String.self, from: data)
                    completion(.success(item))
                } catch {
                    completion(.failure(.failedToEncodeToData))
                }
            } else {
                completion(.failure(.failedToConvertToDate))
            }
        case errSecItemNotFound:
            completion(.failure(.errSecItemNotFound))
        default:
            completion(.failure(.unknownError(error)))
        }
    }
    
    func update<T>(
        _ item: T,
        service: String,
        account: String,
        completion: (Result<Void, ResultError>) -> Void
    ) where T: Codable {
        var secData: Data
        do {
            secData = try JSONEncoder().encode(item)
        } catch {
            completion(.failure(.failedToEncodeToData))
            return
        }
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        let attributesToUpdate = [kSecValueData: secData] as CFDictionary
        let status = SecItemUpdate(query, attributesToUpdate)
        let error = NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        
        // Посмотреть коды ошибок можно тут https://www.osstatus.com
        switch status {
        case errSecSuccess:
            completion(.success(()))
        case errSecItemNotFound:
            completion(.failure(.errSecItemNotFound))
        default:
            completion(.failure(.unknownError(error)))
        }
    }
    
    func delete(
        service: String,
        account: String,
        completion: (Result<Void, ResultError>) -> Void
    ) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
            ] as CFDictionary
        let status = SecItemDelete(query)
        let error = NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        
        // Посмотреть коды ошибок можно тут https://www.osstatus.com
        switch status {
        case errSecSuccess:
            completion(.success(()))
        case errSecItemNotFound:
            completion(.failure(.errSecItemNotFound))
        default:
            completion(.failure(.unknownError(error)))
        }
    }
    
    // ???: Второй вариант через выбрасывания ошибки, что лучше, это или через замыкание?
    func delete(service: String, account: String) throws {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
            ] as CFDictionary
        let status = SecItemDelete(query)
        let error = NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        
        guard status != errSecSuccess else {
            switch status {
            case errSecItemNotFound:
                throw KeychainError.errSecItemNotFound
            default:
                throw KeychainError.unknownError(error)
            }
        }
    }
}

// MARK: - KeychainError
extension KeychainStorageService {
    /// Перечисление известных ошибок Keychain
    enum KeychainError: Error {
        case errSecItemNotFound
        case errSecDuplicateItem
        case failedToConvertToDate
        case failedToEncodeToData
        case failedToDecodeToType
        case unknownError(Error)
    }
}
