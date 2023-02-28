//
//  AdvancedViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit
import SnapKit

// Основной контроллер представения с подгрузкой случайных фотографий и строкой поиска
final class AdvancedViewController: UIViewController {
    // MARK: - Свойства и объекты UI
    typealias DataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>
    
    private lazy var collectionView = UICollectionView(frame: CGRect.zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout.init())
    private var dataSource: DataSource?
    private var timer: Timer?
    private var currenLayoutType = 1
    
    private var viewModel: AdvancedViewModelProtocol
    
    // MARK: - Методы жиненного цикла view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartPhoto()
        setupElements()
    }
    
    init(viewModel: AdvancedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Конфигурация элементов ViewController
    private func setupElements() {
        view.backgroundColor = .viewBackgroundColor
        
        /// `Navigation Bar` Setup
        title = "Photo Engine".localize()
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
        collectionView.collectionViewLayout = setViewLayout(currenLayoutType)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        createDataSource()
        
        /// Registration of cells
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        /// Adding elements to the screen
        view.addSubview(collectionView)
        
        /// Setting up the location of elements on the screen
        collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Изменение Layout Of Collection View
    @objc func changeLayoutButton() {
        print("Прошла кнопка, currenLayoutType - " + "\(currenLayoutType)")
        currenLayoutType == 3 ? (currenLayoutType = 1) : (currenLayoutType += 1)
        collectionView.setCollectionViewLayout(setViewLayout(currenLayoutType), animated: true)
    }
    
    private func setViewLayout(_ layoutNumber: Int) -> UICollectionViewLayout {
        var layout: UICollectionViewLayout
        
        switch layoutNumber {
        case 2: layout = createSecondLayout()
        case 3: layout = createThirdLayout()
        default: layout = createFirstLayout()
        }
        return layout
    }
    
    /// Стартовая загрузка данных
    private func getStartPhoto() {
        viewModel.getRandomPhotos {
            print("______Обновление экрана")
            self.reloadData()
        }
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
    /// Действие при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.navigateToPhotoDetailScreen(index: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate
extension AdvancedViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.trimmingCharacters(in: .whitespaces) != "" else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] (_) in
            
            self?.viewModel.getSearchPhotos(searchTerm: searchText, completion: {
                self?.reloadData()
            })
        })
    }
}

// MARK: - Cмена типа UICollectionViewLayout
extension AdvancedViewController {
    
    // MARK: Первый тип Layout (отобраажения/расположения фотографий)
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
