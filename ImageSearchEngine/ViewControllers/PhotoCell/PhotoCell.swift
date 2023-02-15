//
//  PhotoCell.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    // MARK: - Элементы PhotoCell
    private let photoImageView = UIImageView()
    private let authorNameLabel = UILabel.confAuthorNameLabel()
    private let isFavoriteButton = UIButton(type: .system)
    
    // MARK: - Свойства PhotoCell
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
    
    // MARK: - Initiation
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
    
    // MARK: - Function
    private func favoriteButtonAction() {
        isFavoritePhoto.toggle()
        isFavoriteButton.shake()
        viewModel.changePhotoStatus()
    }
    
    // MARK: - Настройка элементов
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
        
        addSubview(photoImageView)
        addSubview(authorNameLabel)
        addSubview(isFavoriteButton)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        isFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        /// Настройка констрейнтов
        NSLayoutConstraint.activate([
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        
        authorNameLabel.heightAnchor.constraint(equalToConstant: 20),
        authorNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        authorNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        authorNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        
        isFavoriteButton.topAnchor.constraint(equalTo: self.topAnchor),
        isFavoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        isFavoriteButton.heightAnchor.constraint(equalToConstant: sizeOfFavoriteButton),
        isFavoriteButton.widthAnchor.constraint(equalToConstant: sizeOfFavoriteButton)
        ])
    }  
}
