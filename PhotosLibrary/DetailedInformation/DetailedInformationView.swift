//
//  DetailedInformationView.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 31.10.2021.
//

import UIKit
import SDWebImage

class DetailedInformationView: UIView {
    
    var delegate: DetailedInformationViewControllerDelegate? {
        didSet {
            guard let delegate = delegate else { return }
            delegate.getDetailsOfPhoto { [weak self] photo in
                guard let photo = photo else { return }
                self?.fillLabels(photo: photo)
            }
        }
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let photoImageView: ScaledHeightImageView = {
        let imageView = ScaledHeightImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let createdAtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let downloadsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "???????????????????? ????????????????????:"
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let downloadsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "heart", withConfiguration: imageConfiguration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func favouriteButtonTapped() {
        guard let delegate = delegate else { return }
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        if favouriteButton.currentImage == UIImage(systemName: "heart", withConfiguration: imageConfiguration) {
            self.photoIsLiked()
            delegate.savePhoto()
        } else {
            self.photoIsUnliked()
            delegate.deletePhoto()
        }
    }
    
    private func photoIsLiked() {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "heart.fill", withConfiguration: imageConfiguration)
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.tintColor = .systemRed
    }
    
    private func photoIsUnliked() {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "heart", withConfiguration: imageConfiguration)
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.tintColor = .systemGray
    }
    
    private func fillLabels(photo: PhotoDetails) {
        guard let delegate = delegate else { return }
        let savedPhotos = delegate.getSavedPhotos()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = formatter.date(from: photo.createdAt) else { return }
        formatter.dateFormat = "dd.MM.yyyy"
        userProfileImageView.sd_setImage(with: URL(string: delegate.getProfileImageUrl()), completed: nil)
        photoImageView.sd_setImage(with: URL(string: photo.urls.regular), completed: nil)
        authorLabel.text = photo.user.name
        downloadsLabel.text = "\(photo.downloads)"
        createdDateLabel.text = formatter.string(from: date)
        if let country = photo.location.country {
            if let city = photo.location.city {
                locationLabel.text = city + ", " + country
            } else {
                locationLabel.text = country
            }
        } else {
            locationLabel.text = "-"
        }
        if savedPhotos.contains(where: { $0.id == photo.id}) {
            self.photoIsLiked()
        }
    }
    
    private func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(photoImageView)
        scrollView.addSubview(userProfileImageView)
        scrollView.addSubview(createdAtImageView)
        scrollView.addSubview(locationImageView)
        scrollView.addSubview(downloadsTitleLabel)
        scrollView.addSubview(authorLabel)
        scrollView.addSubview(downloadsLabel)
        scrollView.addSubview(createdDateLabel)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(favouriteButton)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            userProfileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            userProfileImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 60),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 60),
            
            authorLabel.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 10),
            authorLabel.heightAnchor.constraint(equalToConstant: 25),
            
            photoImageView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 20),
            photoImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            photoImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            photoImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -40),
            
            favouriteButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            favouriteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            downloadsTitleLabel.topAnchor.constraint(equalTo: favouriteButton.bottomAnchor, constant: 10),
            downloadsTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            downloadsTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            downloadsLabel.centerYAnchor.constraint(equalTo: downloadsTitleLabel.centerYAnchor),
            downloadsLabel.leadingAnchor.constraint(equalTo: downloadsTitleLabel.trailingAnchor, constant: 10),
            downloadsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            createdAtImageView.centerXAnchor.constraint(equalTo: favouriteButton.centerXAnchor),
            createdAtImageView.topAnchor.constraint(equalTo: downloadsTitleLabel.bottomAnchor, constant: 10),
            createdAtImageView.heightAnchor.constraint(equalToConstant: 20),
            createdAtImageView.widthAnchor.constraint(equalToConstant: 20),
            
            createdDateLabel.centerYAnchor.constraint(equalTo: createdAtImageView.centerYAnchor),
            createdDateLabel.leadingAnchor.constraint(equalTo: createdAtImageView.trailingAnchor, constant: 10),
            
            locationImageView.centerXAnchor.constraint(equalTo: createdAtImageView.centerXAnchor),
            locationImageView.topAnchor.constraint(equalTo: createdAtImageView.bottomAnchor, constant: 10),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 10),
            locationLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}

// MARK: - ScaledHeightImageView
class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}
