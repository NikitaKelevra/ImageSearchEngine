//
//  UILabel+Extensions.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 17.10.2022.
//

import UIKit

extension UILabel {

    static func configurationLabel(withTextAlpha alpha: CGFloat) -> UILabel{
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white.withAlphaComponent(alpha)
        label.textAlignment = .center
        label.highlightedTextColor = .black
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 0.8
        label.backgroundColor = .clear.withAlphaComponent(0.5)
        return label
    }
}
