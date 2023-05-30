//
//  MVXProtocols.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 30.05.2023.
//

import UIKit

// Протокол компоновки модулей на базе UIViewController
protocol BaseAssembly {

    /// Собрать модуль
    ///  - Returns: UIViewController компонующего модуля
    func configure(viewController: UIViewController)
}

// Протокол 
protocol BaseRouting {
    func RouteTo(target: Any)
}
