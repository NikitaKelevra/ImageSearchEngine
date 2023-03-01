//
//  PhotoCell.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit
import SnapKit

final class PhotoCell: UICollectionViewCell {
    
    // MARK: - Свойства и Элементы ячейки
    private let photoImageView = UIImageView()
    private let authorNameLabel = UILabel.confAuthorNameLabel()
    private let isFavoriteButton = UIButton(type: .system)
    
    static var reuseId: String = "PhotoCell"
    
    var viewModel: PhotoCellViewModelProtocol! {
        didSet {
            authorNameLabel.text = viewModel.authorName
            isFavoritePhoto = viewModel.isFavorite
            viewModel.getImage { image in
                self.photoImageView.image = image
            }
        }
    }
    
    private var isFavoritePhoto = false {
        didSet {
            isFavoriteButton.tintColor = isFavoritePhoto ? redButtonColor : blackButtonColor
        }
    }
    
    private let cornerRadius: CGFloat = 10
    private var sizeOfFavoriteButton: Double = 50.0
    private let blackButtonColor = UIColor.black.withAlphaComponent(0.5)
    private let redButtonColor = UIColor.red.withAlphaComponent(0.8)
    
    // MARK: - Инициализатор
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    // MARK: - Приватные функции
    ///Действия при нажатии на кнопку добавления в избранное (поставить лайк)
    private func favoriteButtonAction() {
        isFavoritePhoto.toggle()
        isFavoriteButton.shake()
        viewModel.changePhotoStatus()
    }
    
    /// Настройка параметров элементов ячейки
    private func setupElements() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        
        authorNameLabel.clipsToBounds = true
        authorNameLabel.layer.cornerRadius = cornerRadius
        
        photoImageView.contentMode = .scaleAspectFill
        
        isFavoriteButton.setImage(UIImage(systemName: "heart.fill") , for: .normal)
        isFavoriteButton.addAction(UIAction(handler: { _ in
            self.favoriteButtonAction()
        }), for: .touchUpInside)
        
        /// Добавление элементов `Subview` на основной экран `View`
        addSubview(photoImageView)
        addSubview(authorNameLabel)
        addSubview(isFavoriteButton)
        
        photoImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview()
            make.height.equalTo(20)
        }
        
        isFavoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.height.width.equalTo(sizeOfFavoriteButton)
        }
    }  
}
