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

// Стартовый контроллер представения случайных фотографий
final class AdvancedViewController: UIViewController {
    // MARK: - Propherties & typealias / Свойства и объекты UI
    
    typealias DataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>
    
    private lazy var collectionView = UICollectionView(frame: CGRect.zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout.init())
    private var dataSource: DataSource?
    private var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    private var viewModel: AdvancedViewModelProtocol! {
        didSet {
            viewModel.getRandomPhotos {
                print("Обновление фоток")
                self.reloadData()
            }
        }
    }
    
    // MARK: - UIViewController lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AdvancedViewModel()
        setupElements()
        createDataSource()
    }
    
    // MARK: - Изменение Layout Of Collection View
    @objc func changeLayoutButton() {
        print("Прошла кнопка")
//        print(viewModel.layoutType)
        viewModel.layoutType += 1
        collectionView.setCollectionViewLayout(setViewLayout(viewModel.layoutType), animated: true)
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
                                                            action: #selector(changeLayoutButton))
        
        /// `SeacrhController` settings
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        /// `CollectionView` settings
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = setViewLayout(viewModel.layoutType)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        
        /// Registration of cells
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        /// Adding elements to the screen
        view.addSubview(collectionView)
        
        /// Setting up the location of elements on the screen
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Навигация
    // Переход на экран детальной информации
    private func showPhotoDetailsVC(viewModel: DetailsViewModelProtocol) {
        let detailsVC = DetailsViewController()
        detailsVC.viewModel = viewModel
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - DataSource, Snapshot and Layout settings
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.photos, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func createDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { [weak self] (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell
            cell?.viewModel = self?.viewModel.photoCellViewModel(at: indexPath)
            return cell
        })
    }
}

// MARK: - UICollectionViewDelegate
extension AdvancedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailsViewModel = viewModel.detailsViewModel(at: indexPath)
        showPhotoDetailsVC(viewModel: detailsViewModel)
    }
}

// MARK: - UISearchBarDelegate
extension AdvancedViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print(searchText)
        guard searchText.trimmingCharacters(in: .whitespaces) != "" else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            
            self?.viewModel.getSearchPhotos(searchTerm: searchText, completion: {
                self?.reloadData()
            })
        })
    }
}

// MARK: - Cмена типа UICollectionViewLayout
extension AdvancedViewController {
    
    // MARK: - Функция смены типа Layout
    func setViewLayout(_ layoutNumber: Int) -> UICollectionViewLayout {
        var layout: UICollectionViewLayout
        
        switch layoutNumber {
        case 2: layout = createSecondLayout()
        case 3: layout = createThirdLayout()
            
        default: viewModel.layoutType = 1
            layout = createFirstLayout()
        }
        return layout
    }
    
    // MARK: - Первый тип Layout (отобраажения/расположения фотографий)
    private func createFirstLayout() -> UICollectionViewLayout {
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
    
    // MARK: Второй тип Layout (отобраажения/расположения фотографий)
    private func createSecondLayout() -> UICollectionViewLayout {
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
    
    // MARK: Третий тип Layout (отобраажения/расположения фотографий)
    private func createThirdLayout() -> UICollectionViewLayout {
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
