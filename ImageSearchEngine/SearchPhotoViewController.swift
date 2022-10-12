//
//  SearchPhotoViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchPhotoViewController: UIViewController {

    
    // MARK: - Propherties
    typealias DataSource = UICollectionViewDiffableDataSource<PhotoListSection, UnsplashPhoto>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, UnsplashPhoto>
    
    private var collectionView: UICollectionView!
    
    private var dataSource: DataSource?
    private var channels: [UnsplashPhoto] = [] {
        didSet{
//            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        setupElements()
        


    }


    // MARK: - View Controller elements setup
    private func setupElements() {
        
        // `CollectionView` settings
                collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
                collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                collectionView.backgroundColor = .clear
                
                collectionView.dragInteractionEnabled = true
//                collectionView.delegate = self
//                collectionView.dragDelegate = self
//                collectionView.dropDelegate = self

                /// Registration of cells
                collectionView.register(<#T##AnyClass?#>, forCellWithReuseIdentifier: PhotoCell.reuseId)
        (UINib(nibName: String(describing: PhotoCell.self), bundle: nil),
                                        forCellWithReuseIdentifier: PhotoCell.reuseId)
                
                /// Adding elements to the screen
                view.addSubview(collectionView)
        
        /// Setting up the location of elements on the screen
              collectionView.translatesAutoresizingMaskIntoConstraints = false
              
              let safeAreaGuide = self.view.safeAreaLayoutGuide
              
              NSLayoutConstraint.activate([
                  collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
                  collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
                  collectionView.topAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
                  collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
              ])
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(86))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 8, bottom: 0, trailing: 8)
            
            return section
        }
        return layout
    }
    


}
