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
        
        setupElements()
        generateTabBar()
        setTabBarAppearance()

    }
    // MARK: - Functions
    
    private func setupElements() {
        view.backgroundColor = .green
        ///TabBar setup
//        tabBar.tintColor = #colorLiteral(red: 0.880017817, green: 0.9453510642, blue: 0.6683167815, alpha: 1)
//        tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    }
    
    private func generateTabBar() {
        viewControllers = [
            generateNavigationController(rootViewController: AdvancedViewController(),
                                         title: "All Photos",
                                         image: UIImage(systemName: "ticket")),
            generateNavigationController(rootViewController: FavoritePhotoViewController(),
                                         title: "My Favourites",
                                         image: UIImage(systemName: "heart"))
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)

        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
    
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
        tabBar.tintColor = .selectesTextColor
        tabBar.unselectedItemTintColor = .unselectedTextColor
        tabBar.standardAppearance.backgroundColor = .green
        tabBar.layer.backgroundColor = UIColor.white.cgColor
    }
}
