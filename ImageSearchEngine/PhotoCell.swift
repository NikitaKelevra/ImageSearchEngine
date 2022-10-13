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
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
    // MARK: - Initiation
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Function
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    /// Cell configuration
    func configure(with photo: Photo) {
        let photoUrl = photo.urls["regular"]
        guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
        photoImageView.sd_setImage(with: url, completed: nil)
        
        
//        channelTitleLabel.text = channel.nameRu
//        channelProgramTitle.text = channel.current.title
//        getImageFromUrl(channel.image)
//        cellChannel = channel
//
//        isFavoriteContact = isFavorite
    }
    
    
    // MARK: - Private function
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
    }  
}
