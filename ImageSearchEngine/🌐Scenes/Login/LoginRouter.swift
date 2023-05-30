//
//  LoginRouter.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 30.05.2023.
//

import UIKit

protocol LoginRouterProtocol: BaseRouting {
    
}

final class LoginRouter {
    enum Targets {
        case registration, enter
    }
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - LoginRouterProtocol
extension LoginRouter: LoginRouterProtocol {
    func RouteTo(target: Any) {
        guard let loginTarget = target as? LoginRouter.Targets else { return }
        
        switch loginTarget {
            
        case .enter:
            print("enter to login flow")
        case .registration:
            print("enter to registration")
            let vc = RegistrationViewController()
            
        }
        
    }

}
