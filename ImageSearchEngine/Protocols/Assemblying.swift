//
//  Assemblying.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 25.02.2023.
//

import UIKit

// Протокол компоновки модулей на базе UIViewController
protocol Assemblying {

    /// Собрать модуль
    ///  - Returns: UIViewController компонующего модуля
    func createModule() -> UIViewController
}
