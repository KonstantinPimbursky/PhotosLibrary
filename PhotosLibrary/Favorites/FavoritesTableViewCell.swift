//
//  FavoritesTableViewCell.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 20.10.2021.
//

import UIKit
import SDWebImage

class FavoritesTableViewCell: UITableViewCell {
    
    var photo: PhotoRealmObject! {
        didSet {
            fillLabels()
        }
    }
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupSubviews() {
        addSubview(photoImageView)
        addSubview(userNameLabel)
        
        let constraints = [
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
            userNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            photoImageView.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.trailingAnchor.constraint(equalTo: userNameLabel.leadingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func fillLabels() {
        photoImageView.sd_setImage(with: URL(string: photo.url), completed: nil)
        userNameLabel.text = photo.userName
    }

}
