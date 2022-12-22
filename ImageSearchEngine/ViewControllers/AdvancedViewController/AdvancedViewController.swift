//
//  SearchPhotoViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

enum PhotoListSection: Int {
    case main
}

class AdvancedViewController: UIViewController {
    // MARK: - Propherties & typealias
    
    typealias DataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource?
    private var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    // AdvancedViewControllerViewModel
    private var viewModel: AdvancedViewModelProtocol! {
        didSet {
            viewModel.getRandomPhotos {
                self.reloadData()
            }
        }
    }
    
    // Main array of photo
    private var photos: [Photo] {
        viewModel.photos
    }
    
    // Array of favorite photo
    private var favoritePhotos: [Photo] {
        DataManager.shared.fetchPhotos()
    }
    
    // Change Collection View Layout
    private var numberOfLayoutType = 1
    
//    private let allowSearchCharacters = ["#", "$", "!", "&","@"]
    
    // MARK: - UIViewController lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AdvancedViewModel()
        
        setupElements()
        createDataSource()
    }
    
    
    // MARK: - Change Layout Of Collection View
    @objc func clickChangeViewButton() {
        numberOfLayoutType += 1
        collectionView.setCollectionViewLayout(setViewLayout(numberOfLayoutType), animated: true)
    }
    
    private func setViewLayout(_ layoutNumber: Int) -> UICollectionViewLayout {
        var layout: UICollectionViewLayout
        
        switch layoutNumber {
        case 2: layout = createSecondLayout()
        case 3: layout = createThirdLayout()
            
        default: numberOfLayoutType = 1
            layout = createFirstLayout()
        }
        return layout
    }
    
    // MARK: - Configuring ViewController Elements
    private func setupElements() {
        view.backgroundColor = .viewBackgroundColor
        
        /// `Navigation Bar` Setup
        title = "Photo Engine"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "doc.plaintext"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(clickChangeViewButton))
        
        /// `SeacrhController` settings
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        /// `CollectionView` settings
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setViewLayout(numberOfLayoutType))
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        
        /// Registration of cells
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        /// Adding elements to the screen
        view.addSubview(collectionView)
        
        /// Setting up the location of elements on the screen
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
//        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Navigation
    
    private func showPhotoDetailsVC(photo: Photo) {
        let detailsVC = DetailsViewController()
        detailsVC.photo = photo
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - DataSource, Snapshot and Layout settings
    
    func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func createDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let isFavorite = self.favoritePhotos.contains(photo)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId,
                                                          for: indexPath) as? PhotoCell
            cell?.configure(with: photo, isFavorite: isFavorite)
            return cell
        })
    }

}

// MARK: - UICollectionViewDelegate
extension AdvancedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        showPhotoDetailsVC(photo: photos[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate
extension AdvancedViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print(searchText)
//        if searchText.contains(where: { char in
//            allowSearchCharacters.contains(String(char))
//        }) {
//            showAlert(with: "Incorrect input format",
//                      and: "Do not use the following characters: \(allowSearchCharacters)")
//            searchBar.text = ""
//        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            self?.viewModel.getSearchPhotos(searchTerm: searchText, completion: {
                self?.reloadData()
            })
        })
    }
}

// MARK: - Alert Controller
extension AdvancedViewController {    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
