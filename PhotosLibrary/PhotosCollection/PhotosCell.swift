//
//  PhotosCell.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PhotosCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            updateSelectedCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateSelectedCell()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func updateSelectedCell() {
        photoImageView.alpha = isSelected ? 0.7 : 1
        checkMark.alpha = isSelected ? 1 : 0
    }
    
    private func setupSubviews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(checkMark)
        
        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            checkMark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8),
            checkMark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
