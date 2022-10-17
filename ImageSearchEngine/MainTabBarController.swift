//
//  MainTabBarController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
  
    
    // MARK: - UIViewController lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarAppearance()

    }
    // MARK: - Functions
    
    private func generateTabBar() {
        viewControllers = [
            generateNavigationController(rootViewController: AdvancedViewController(),
                                         title: "All Photos",
                                         image: UIImage(systemName: "gear")),
            generateNavigationController(rootViewController: FavoritePhotoViewController(),
                                         title: "My Favourites",
                                         image: UIImage(systemName: "heart"))
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
    
        navigationVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationVC.navigationBar.shadowImage = UIImage()
        navigationVC.navigationBar.tintColor = .black
        return navigationVC
    }
    
    private func setTabBarAppearance() {
        
        // Setting up tabbar rounding
        let positiononX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positiononX * 2
        let height = tabBar.bounds.height + positionOnY * 2
         
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positiononX,
                                y: tabBar.bounds.minY - positionOnY,
                                width: width,
                                height: height),
            cornerRadius: height / 2
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        // Setting Tabbar colors
        roundLayer.fillColor = UIColor.mainBackgroundColor.cgColor
        tabBar.unselectedItemTintColor = .unselectedTextColor
        tabBar.tintColor = .selectesTextColor
        tabBar.barTintColor = .clear
        tabBar.layer.borderColor = UIColor.black.cgColor
//        tabBar.standardAppearance.backgroundColor = .green
//        tabBar.layer.backgroundColor = UIColor.blue.cgColor
    }
}
