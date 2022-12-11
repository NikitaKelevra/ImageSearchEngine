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
/*
        // Setting up tabbar rounding
        let x: CGFloat = 10
        let y: CGFloat = 14
        let width = tabBar.bounds.width - x * 2
        let height = tabBar.bounds.height + y * 2

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: x,
                                y: tabBar.bounds.minY - y,
                                width: width,
                                height: height),
            cornerRadius: height / 3.2
        )
        roundLayer.path = bezierPath.cgPath
        
        
         tab bar shadow
        roundLayer.shadowColor = UIColor.viewBackgroundColor.cgColor
        roundLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        roundLayer.shadowRadius = 5.0
        roundLayer.shadowOpacity = 0.5
        
         add tab bar layer
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
         fix items positioning
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        
         setting tab bar colors
        roundLayer.fillColor = UIColor.mainBackgroundColor.cgColor
 */
        tabBar.unselectedItemTintColor = .unselectedTextColor
        tabBar.tintColor = .selectesTextColor
        tabBar.layer.borderColor = UIColor.black.cgColor
        
        tabBar.barTintColor = .black
        

    }
}
