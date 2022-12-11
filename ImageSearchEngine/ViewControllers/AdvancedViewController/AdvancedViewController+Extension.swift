//
//  AdvancedViewController+Extension.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 18.10.2022.
//

import UIKit

extension AdvancedViewController {
    
    // MARK: Первый вид отобраажения/расположения фотографий
    func createFirstLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5,
                                                              bottom: 5, trailing: 5)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 8,
                                                                 bottom: 0, trailing: 8)
            return section
        }
        return layout
    }
    
    // MARK: Второй вид отобраажения/расположения фотографий
    func createSecondLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5,
                                                              bottom: 5, trailing: 5)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 8,
                                                                 bottom: 0, trailing: 8)
            return section
        }
        return layout
    }
    
    // MARK: Второй вид отобраажения/расположения фотографий
    func createThirdLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5,
                                                              bottom: 5, trailing: 5)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 8,
                                                                 bottom: 0, trailing: 8)
            return section
        }
        return layout
    }

}
