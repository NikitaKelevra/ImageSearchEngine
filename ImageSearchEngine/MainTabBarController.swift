//
//  MainTabBarController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewControllers = [
            generateNavigationController(rootViewController: SearchPhotoViewController(), title: "Photos", image: UIImage(systemName: "ticket")!),
            generateNavigationController(rootViewController: FavoritePhotoViewController(), title: "Favourites", image: UIImage(systemName: "heart")!)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
