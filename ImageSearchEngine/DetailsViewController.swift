//
//  DetailsViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 14.10.2022.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    // MARK: - Property
    var photo: Photo? {
        didSet {
            configure()
        }
    }
    
    var barFrame:CGRect?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
       return imageView
   }()
    
    private var authorNameLabel: UILabel = {
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
    
    private var creationDataLabel: UILabel = {
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
    
    private var photoLocationLabel: UILabel = {
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
    
    private var downloadCountLabel: UILabel = {
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
    
    /// Общий стек информации по фотографии
    private let photoDetailsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    
    // MARK: - VC lifecircle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if  let tabBar = self.tabBarController?.tabBar {
           self.barFrame = tabBar.frame
            
            UIView.animate(withDuration: 0.3) {
                () -> Void in
                       let newBarFrame = CGRectMake(self.barFrame!.origin.x,
                                                    self.view.frame.size.height,
                                                    self.barFrame!.size.width,
                                                    self.barFrame!.size.height)
                       tabBar.frame = newBarFrame
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if barFrame != nil {
            UIView.animate(withDuration: 0.3) { () -> Void in
                let newBarFrame = CGRectMake(self.barFrame!.origin.x,
                                             self.view.frame.size.height - self.barFrame!.size.height,
                                             self.view.frame.size.width,
                                             self.barFrame!.size.height)
                self.tabBarController?.tabBar.frame = newBarFrame
            }
        }
    }
    
    // MARK: - Function
    private func configure(){
        setupPhoto()
        
        guard let author = photo?.user.name else {
            authorNameLabel.isEnabled = false
            return
        }
        authorNameLabel.text = "Author: \(author)"
        
        
        guard let createdAt: String = photo?.createdAt else {
            creationDataLabel.isEnabled = false
            return
        }
        creationDataLabel.text = "Creation at: \(createdAt)"
        
        guard let city: String = photo?.location?.city else {
            photoLocationLabel.isEnabled = false
            return
        }
        photoLocationLabel.text = "Location: \(city)"
        
        guard let likes = photo?.likes else {
            downloadCountLabel.isEnabled = false
            return
        }
        downloadCountLabel.text = "Download count: \(likes)"
    }
    
    private func setupPhoto() {
        guard let imageURL = photo?.urls["full"],
                let url = URL(string: imageURL) else { return }
        photoImageView.sd_setImage(with: url, completed: nil)
    }

    private func addSubviews() {
        photoDetailsStack.addArrangedSubview(authorNameLabel)
        photoDetailsStack.addArrangedSubview(creationDataLabel)
        photoDetailsStack.addArrangedSubview(photoLocationLabel)
        photoDetailsStack.addArrangedSubview(downloadCountLabel)
        view.addSubview(photoImageView)
        view.addSubview(photoDetailsStack)
    }
    
    private func setupElements() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        
            photoDetailsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            photoDetailsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            photoDetailsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
