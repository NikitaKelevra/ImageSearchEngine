//
//  TokenCheckerManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 31.05.2023.
//

import Foundation

/// Протокол для работы с менеджером проверки токенов
protocol ITokenCheckerManagement {
  /// Метод для проверки наличия токена в keychain
  /// - Parameters:
  ///   - login: Принимает логин пользователя
  ///   - completion: возвращает Result типа Void или ``Error``.
  ///     - Result Void: Токен успешно получен и обновлён в keychain, или еще жив
  ///     - Result Error: может вернуть как Error от KeychainStorage, так и Error сервера.
  ///     Это нужно учитывать при обработке ошибок и написания логики дальнейшего действия.
  ///     - При возврате KeychainError приходит enum известных возможных ошибок.
  ///     Если ошибка неизвестна, в ассоциативном значении, возвращает ошибку типа
  ///     NSOSStatusErrorDomain.
  func checkTokenInLocalStorage(
    for login: String,
    completion: (Result<String, Error>) -> Void
  )
}

/// Менеджер для проверки токенов
final class TokenCheckerManager: ITokenCheckerManagement {

  private let keychainStorageService: IKeychainStorageService
  /// Имя сервиса, для создания метки в хранилище Keychain.
  /// - Имя должно быть уникальным, так-как именно по нему происходит поиск сохраненного токена.
  /// В приложении может быть несколько пользователей с разными логинами. И нужно понимать,
  /// что логин в хранилище Keychain относится именно к нашему приложению.
  private var serviceName = "access-token-sbmp"

  /// Инициализатор менеджера проверки токенов
  /// - Parameter keychainStorageService: принимает сервис для работы с хранилищем
  /// Keychain
  init(keychainStorageService: IKeychainStorageService) {
    self.keychainStorageService = keychainStorageService
  }

  enum TokenCheckerManagerError: Error {
    case testError
  }

  func checkTokenInLocalStorage(
    for login: String,
    completion: (Result<String, Error>) -> Void
  ) {

    // 1.1 Проверяем, жив ли токен
    // 2. Если токена нет или он не живой, отправляем на логин
    // 3. Выбираем вход или регистрация
    // 3.1 Вход
    // 3.1.1 Вход с боевыми данными
    // 3.1.2 Вход с тестовыми данными
    // 4. Регистрация

    // TODO: Mock
//    let mockAccountModel = MockService.shared.accountModel()
//    AccountManager.shared.update(accountModel: mockAccountModel, withSych: false)
//    completion(.success(()))

    // TODO: Вернуть, когда появится сервер

    keychainStorageService.fetch(
      service: serviceName,
      account: login
    ) { result in
      switch result {
      case .success(let token):

        guard token == "testToken" else {
          return
        }
        completion(.success(token))
        //completion(.failure(TokenCheckerManagerError.testError))
        return

        // TODO: Раскомментить, когда появится сервер
//        checkTokenInServer(token, login) { result in
//          switch result {
//          case .success():
//            completion(.success(token))
//          case .failure(let error):
//            completion(.failure(error))
//          }
//        }

      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  /// Метод проверки валидности локального токена и токена с сервера
  /// - Parameters:
  ///   - token: принимает локальный токен
  ///   - login: принимает логин пользователя
  ///   - completion: возвращает Result типа Void или ``Error``.
  ///     - Result Void: Токен успешно получен и обновлён в keychain, или еще жив
  ///     - Result Error: может вернуть как Error от KeychainStorage, так и Error сервера.
  private func checkTokenInServer(
    _ token: String,
    _ login: String,
    completion: (Result<Void, Error>) -> Void
  ) {
    var serverToken = "" // поменяется после ответа от сервера
    // TODO: (SBMP-14) логика вызова запроса к серверу для запроса нового токена
    // если сервер не вернул токен, выход на экран логина.
    // Так же нужно будет обработать ответ от сервера, в случае если он не
    // вернет токен и выдаст ошибку

    // проверка полученного токена с сервера после отработки не написанной логики
    if serverToken == token {
      completion(.success(()))
    } else {
      keychainStorageService.update(
        serverToken,
        service: serviceName,
        account: login
      ) { result in
        switch result {
        case .success():
          completion(.success(()))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
