//
//  FavoritePhotoViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit
import SnapKit

// Контроллер представения фотографий отмеченных лайком (избранных)
final class FavoritePhotoViewController: UIViewController {
    // MARK: - Propherties & typealias / Свойства и объекты UI
    typealias DataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>
    
    private lazy var collectionView = UICollectionView(frame: CGRect.zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout.init())
    private var dataSource: DataSource?
    
    private var viewModel: FavoritePhotoViewModelProtocol {
        didSet {
            self.reloadData()
        }
    }
    
    // MARK: - Методы жиненного цикла view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
    }
    
    init(viewModel: FavoritePhotoViewModelProtocol) {
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
        title = "Favorites Photo".localize()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        /// `CollectionView` settings
        collectionView.frame = view.bounds
        collectionView.collectionViewLayout = createLayout()
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
    
    // MARK: - DataSource, Snapshot and Layout settings
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.favoritePhotos, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func createDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { [weak self]  (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell
            cell?.viewModel = self?.viewModel.photoCellViewModel(at: indexPath)
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
        viewModel.navigateToPhotoDetailScreen(index: indexPath.row)
    }
}

