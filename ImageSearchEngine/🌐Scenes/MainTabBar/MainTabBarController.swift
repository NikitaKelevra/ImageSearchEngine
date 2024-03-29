//
//  MainTabBarController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

// Основной контроллер панели вкладок
final class MainTabBarController: UITabBarController {
    // MARK: - Свойства
    private var layer = CAShapeLayer() /// Слой внешнего вида `TabBar`
    
    // MARK: - Методы жиненного цикла
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
    }
    
    // MARK: - Функции
    /// Настраиваем / кастомизируем внешний вид панели вкладок `TabBar`
    private func setTabBarAppearance() {
        /// Делаем `TabBar` прозрачным
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    
        /// Настраиваем слой `TabBar`
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 12
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,
                                y: tabBar.bounds.minY - positionOnY,
                                width: width,
                                height: height),
            cornerRadius: height / 3
        )
        layer.path = bezierPath.cgPath
        
        /// Добавляем слой `TabBar`
        tabBar.layer.insertSublayer(layer, at: 0)
        
        /// Настраиваем элементы `TabBar`
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        
        /// Настраиваем тени `TabBar`
        layer.shadowColor = UIColor.viewBackgroundColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        
         /// Настраиваем цвета `TabBar`
        layer.fillColor = UIColor.mainBackgroundColor.cgColor
        tabBar.unselectedItemTintColor = .unselectedTextColor
        tabBar.tintColor = .selectesTextColor
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.barTintColor = .black
    }
}
