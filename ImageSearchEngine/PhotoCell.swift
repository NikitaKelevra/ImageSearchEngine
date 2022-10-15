//
//  PhotoCell.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 11.10.2022.
//

import UIKit
import SDWebImage

final class PhotoCell: UICollectionViewCell {
    
    // MARK: - Property
    static var reuseId: String = "PhotoCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
       return imageView
   }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.highlightedTextColor = .black
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 0.8
        label.backgroundColor = .clear.withAlphaComponent(0.5)
        return label
    }()
    
    // MARK: - Initiation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Function
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }

    func configure(with photo: Photo) {
        let photoUrl = photo.urls["regular"]
        guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
        photoImageView.sd_setImage(with: url, completed: nil)
        
        authorNameLabel.text = photo.user.name
    }
    
    private func setupElements() {
        
        addSubview(photoImageView)
        addSubview(authorNameLabel)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        
        authorNameLabel.heightAnchor.constraint(equalToConstant: 20),
        authorNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        authorNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        authorNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }  
}
