//
//  NetworkAccountManager.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 24.05.2023.
//

import Foundation

/// Протокол управления сетевым слоем менеджера аккаунта
protocol NetworkAccountManagment {
    
    
    /// Запрос профиля
    /// - Parameter complition: handler по результату (success, message?, AccountModel?)
    func requestActualAccountModel(complition: @escaping (Bool, String?, AccountModel?)-> Void)
    
    /// <#Description#>
    /// - Parameters:
    ///   - newModel: новая модель
    ///   - complition: handler по результату (success, message?, AccountModel?)
    func updateAccountModel(newModel: AccountModel,
                            complition: @escaping (Bool, String?, AccountModel?)-> Void)
    
    /// <#Description#>
    /// - Parameters:
    ///   - currentModel: локальная модель
    ///   - complition: handler по результату (success, message?, AccountModel?)
    func syncAccountModel(currentModel: AccountModel,
                            complition: @escaping (Bool, String?, AccountModel?)-> Void)
}

/// Сетевой менеджер
final class NetworkAccountManager {
    
}

// MARK: - NetworkAccountManagment
extension NetworkAccountManager: NetworkAccountManagment {
    
    func requestActualAccountModel(complition: @escaping (Bool, String?, AccountModel?) -> Void) {
        
    }
    
    func updateAccountModel(newModel: AccountModel,
                            complition: @escaping (Bool, String?, AccountModel?) -> Void) {
        
    }
    
    func syncAccountModel(currentModel: AccountModel,
                          complition: @escaping (Bool, String?, AccountModel?) -> Void) {
        
    }
    
    
}
