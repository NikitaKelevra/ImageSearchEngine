//
//  AccountManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 14.05.2023.
//

import Foundation


/// Протокол изменения данных об аккаунте
protocol AccountChangable {
    var accountModel: AccountModel { get set }
}

/// Протокол наблюдения за изменениями данных об аккаунте
protocol AccountObservable {
    
}

/// Менеджер пользовательского аккаунта
final class AccountManager: AccountChangable  {
    
    // MARK: - AccountChangable
    var accountModel: AccountModel {
        didSet {
            if accountModel != oldValue {
                networkAccountManager.syncAccountModel(currentModel: accountModel,
                                                       priority: .local) { [weak self] success, errCode, message, model in
                    
                    self?.handleAPIResult(success: success,
                                          errCode: errCode,
                                          message: message,
                                          accountModel: model)
                    
                }
            }
        }
    }
    
    
    static let shared: AccountChangable = AccountManager()
    
    var delegates: [AccountObservable?] = [] // сделать weak
    
    let networkAccountManager: NetworkAccountManagment
    
    
    
    private init() {
        networkAccountManager = NetworkAccountManager()
        accountModel = AccountModel.emptyModel()
    }

}

// MARK: - AccountManager private func
private extension AccountManager {
    
    /// Обработка данных аккаунта пользователя с API сервера
    private func handleAPIResult(success: Bool,
                                 errCode: Int?,
                                 message: String?,
                                 accountModel: AccountModel?) {
        
        
        if success {
            /// Можем упасть на этапе тестирования
            assert(self.accountModel == accountModel)
            
            
        } else if let message = message {
            print(message)
            /// Здесь стоит передать ошибку наблюдателю если известен номер ошибки или есть сообщения в ответе
        } else {
            /// Здесь стоит передать неизвестную ошибку наблюдателю если ничего не вернулось
        }

    }
    
}
