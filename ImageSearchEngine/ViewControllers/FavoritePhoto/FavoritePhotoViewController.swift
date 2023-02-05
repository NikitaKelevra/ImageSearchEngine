//
//  FavoritePhotoViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit


class FavoritePhotoViewController: UIViewController {
    // MARK: - Propherties
    typealias DataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource?

    private var photos: [Photo] = [] {
        didSet{
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
        fetchFavoritePhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoritePhotos()
    }
    
    // MARK: - View Controller elements setup
    private func setupElements() {
        view.backgroundColor = .viewBackgroundColor
        
        /// `Navigation Bar` Setup
        title = "Favorites Photo"
        navigationController?.navigationBar.prefersLargeTitles = false
        
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
////        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.selectesTextColor]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.unselectedTextColor]
//        navBarAppearance.backgroundColor = .clear
//
//        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        /// `CollectionView` settings
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        
        createDataSource()
        
        collectionView.delegate = self
        
//                collectionView.dragDelegate = self
//                collectionView.dropDelegate = self
//        collectionView.dragInteractionEnabled = true
        
        /// Registration of cells
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        
        /// Adding elements to the screen
        view.addSubview(collectionView)
        
        /// Setting up the location of elements on the screen
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    private func fetchFavoritePhotos(){
        photos = DataManager.shared.fetchPhotos()
    }
    
    private func showPhotoDetailsVC(photo: Photo) {
        let detailsVC = DetailsViewController()
        detailsVC.photo = photo
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - DataSource, Snapshot and Layout settings
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func createDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell
//            cell?.viewModel = self?.viewModel.photoCellViewModel(at: indexPath)
            return cell
        })
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 8, bottom: 0, trailing: 8)
            
            return section
        }
        return layout
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritePhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        showPhotoDetailsVC(photo: photos[indexPath.row])
    }
}

