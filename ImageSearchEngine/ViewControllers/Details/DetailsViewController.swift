//
//  DetailsViewController.swift
//  ImageSearchEngine
//
//  Created by Сперанский Никита on 14.10.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: - Свойства и объекты UI
    var viewModel: DetailsViewModelProtocol!
    var barFrame:CGRect?
    
    // MARK: Объекты UI
    private let photoImageView = UIImageView()
    private var authorNameLabel = UILabel.configurationLabel(withTextAlpha: 1)
    private var creationDataLabel = UILabel.configurationLabel(withTextAlpha: 0.8)
    private var photoLocationLabel = UILabel.configurationLabel(withTextAlpha: 0.8)
    private var downloadCountLabel = UILabel.configurationLabel(withTextAlpha: 0.8)
    private let photoDetailsStack = UIStackView()
    
    // MARK: - Методы жиненного цикла view
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupElements()
    }
    
    /// Настройка плавного появления и исчезновения tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if  let tabBar = self.tabBarController?.tabBar {
           self.barFrame = tabBar.frame
            
            UIView.animate(withDuration: 0.5) {
                () -> Void in
                       let newBarFrame = CGRectMake(self.barFrame!.origin.x,
                                                    self.view.frame.size.height + 50,
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
    
    // MARK: - Конфигурация элементов ViewController
    private func configure() {
        viewModel.getImage { image in
            self.photoImageView.image = image
        }
        
        (viewModel.authorNameLabel == nil)
        ? (authorNameLabel.isEnabled = false)
        : (authorNameLabel.text = "Author: ".localize() + (viewModel.authorNameLabel ?? ""))
                
        (viewModel.creationDataLabel == nil)
        ? (creationDataLabel.isEnabled = false)
        : (creationDataLabel.text = "Creation at: ".localize() + (viewModel.creationDataLabel ?? ""))
                
        (viewModel.photoLocationLabel == nil)
        ? (photoLocationLabel.isEnabled = false)
        : (photoLocationLabel.text = "Creation at: ".localize() + (viewModel.photoLocationLabel ?? ""))
           
        (viewModel.photoDownloadCount == nil)
        ? (downloadCountLabel.isEnabled = false)
        : (downloadCountLabel.text = "Download count: ".localize() + (viewModel.photoDownloadCount ?? ""))
    }

    private func setupElements() {
        view.backgroundColor = .viewBackgroundColor
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 10
        
        photoDetailsStack.axis = .vertical
        photoDetailsStack.alignment = .leading
        photoDetailsStack.distribution = .fillProportionally
        photoDetailsStack.spacing = 5
        
        /// Определение иерархии и добавление Subview
        photoDetailsStack.addArrangedSubview(authorNameLabel)
        photoDetailsStack.addArrangedSubview(creationDataLabel)
        photoDetailsStack.addArrangedSubview(photoLocationLabel)
        photoDetailsStack.addArrangedSubview(downloadCountLabel)
        view.addSubview(photoImageView)
        view.addSubview(photoDetailsStack)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        
        /// Настройка констрейнтов
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
