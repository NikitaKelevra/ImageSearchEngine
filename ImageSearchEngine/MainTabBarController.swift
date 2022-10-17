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
        
        setupElements()
        
        viewControllers = [
            generateNavigationController(rootViewController: SearchPhotoViewController(), title: "Photos", image: UIImage(systemName: "ticket")!),
            generateNavigationController(rootViewController: FavoritePhotoViewController(), title: "Favourites", image: UIImage(systemName: "heart")!)
        ]
    }
    
    private func setupElements() {
        view.backgroundColor = .white
        ///TabBar setup
        tabBar.tintColor = #colorLiteral(red: 0.880017817, green: 0.9453510642, blue: 0.6683167815, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        /// Navigation Bar Setup
        title = "Photo Search Engine"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        navigationVC.title = "Photo Search Engine"
        navigationVC.navigationBar.prefersLargeTitles = false
        
        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.880017817, green: 0.9453510642, blue: 0.6683167815, alpha: 1)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.880017817, green: 0.9453510642, blue: 0.6683167815, alpha: 1)]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationVC.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationVC.navigationBar.standardAppearance = navBarAppearance

        return navigationVC
    }
}
