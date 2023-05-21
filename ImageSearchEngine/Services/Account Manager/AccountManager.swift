//
//  AccountManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 14.05.2023.
//

import Foundation


/// Протокол изменения данных об аккаунте
protocol AccountChangable {
    
}

/// Протокол наблюдения за изменениями данных об аккаунте
protocol AccountObservable {
    
}

// MARK: - Менеджер пользовательского аккаунта
final class AccountManager {
    
    static let shared: AccountChangable = AccountManager()
    
    var delegates: [AccountObservable?] = [] // сделать weak
    
    var accountModel: AccountModel {
        didSet {
            if accountModel != oldValue {
                
            }
        }
    }
    
    
    private init() { }
    
    
}

// MARK: - AccountChangable
extension AccountManager: AccountChangable {
    
}
