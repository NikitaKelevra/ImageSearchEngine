//
//  UIString+Localizable.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 07.02.2023.
//

import Foundation

extension String {

    /// Локализация
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
