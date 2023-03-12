//
//  AdvancedViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit
import Combine
import SnapKit

// Основной контроллер представения с подгрузкой случайных фотографий и строкой поиска
final class AdvancedViewController: UIViewController {
    
    // MARK: - Свойства и объекты UI
    typealias DataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>
    
    private lazy var collectionView = UICollectionView(frame: CGRect.zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout.init())
    private var dataSource: DataSource?
    private var collectionViewLayout: CollViewLayoutModuleProtocol
    
//    private var timer: Timer?

    private var viewModel: AdvancedViewModelProtocol
    
    // MARK: - Методы жиненного цикла view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartPhoto()
        setupElements()
    }
    
    init(viewModel: AdvancedViewModelProtocol, layout: CollViewLayoutModuleProtocol) {
        self.viewModel = viewModel
        self.collectionViewLayout = layout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Конфигурация элементов ViewController
    private func setupElements() {
        view.backgroundColor = .viewBackgroundColor
        
        /// Настройка параметров `Navigation Bar`
        title = "Photo Engine".localize()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "doc.plaintext"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeLayoutButton))
        /// Настройка параметров `SeacrhController`
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        /// Настройка параметров `CollectionView`
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = collectionViewLayout.getLayout()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        createDataSource()
        
        /// Регистрация ячеек
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        /// Добавление элементов `Subview` на основной экран `View`
        view.addSubview(collectionView)
        
        /// Настройка расположения элементов на экране
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    /// Изменение Layout Of Collection View
    @objc func changeLayoutButton() {
        collectionView.setCollectionViewLayout(collectionViewLayout.getLayout(), animated: true)
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
    /// Настройка логики поисковой строки Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.trimmingCharacters(in: .whitespaces) != "" else { return }
        viewModel.searchTerm = searchText
        
        
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] (_) in
//
//            self?.viewModel.getSearchPhotos(searchTerm: searchText, completion: {
//                self?.reloadData()
//            })
//        })
    }
}
