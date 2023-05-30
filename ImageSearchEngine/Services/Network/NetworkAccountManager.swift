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
    /// - Parameter complition: handler по результату (success, errorCode, message?, AccountModel?)
    func requestActualAccountModel(complition: @escaping (Bool, Int?, String?, AccountModel?)-> Void)
    
    /// Обновление профиля
    /// - Parameters:
    ///   - newModel: новая модель
    ///   - complition: handler по результату (success, errorCode, message?, AccountModel?)
    func updateAccountModel(newModel: AccountModel,
                            complition: @escaping (Bool, Int?, String?, AccountModel?)-> Void)
    
    /// Синхронизация локального и удаленного профиля
    /// - Parameters:
    ///   - currentModel: локальная модель
    ///   - complition: handler по результату (success, errorCode, message?, AccountModel?)
    ///   - priority: выбор приоритетной версии аккаунта (сервер или устройство)
    func syncAccountModel(currentModel: AccountModel,
                          priority: NetworkAccountManager.SyncPriority ,
                            complition: @escaping (Bool, Int?, String?, AccountModel?)-> Void)
}

/// Сетевой менеджер
final class NetworkAccountManager {
    
    enum SyncPriority {
        case local
        case server
    }
    
}

// MARK: - NetworkAccountManagment
extension NetworkAccountManager: NetworkAccountManagment {
    
    func requestActualAccountModel(complition: @escaping (Bool, Int?, String?, AccountModel?) -> Void) {
        
    }
    
    func updateAccountModel(newModel: AccountModel,
                            complition: @escaping (Bool, Int?, String?, AccountModel?) -> Void) {
        
    }
    
    func syncAccountModel(currentModel: AccountModel,
                          priority: SyncPriority,
                          complition: @escaping (Bool, Int?, String?, AccountModel?) -> Void) {
        
    }
    

    
    
}
