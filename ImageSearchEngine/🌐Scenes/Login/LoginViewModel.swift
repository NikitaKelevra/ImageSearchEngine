//
//  LoginViewModel.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 30.05.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    
    var router: LoginRouterProtocol? { get set }
    var localDataManager: LocalDataManagerProtocol? { get set }
    
    func runRegistrationFlow()
    
}




final class LoginViewModel {
    
    
    
    
    var router: LoginRouterProtocol?
    var localDataManager: LocalDataManagerProtocol?
    

}

// MARK: - LoginViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {
    func runRegistrationFlow() {
        
    }
    
    
}
