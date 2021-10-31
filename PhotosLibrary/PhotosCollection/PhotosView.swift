//
//  PhotosView.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 31.10.2021.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class PhotosView: UIView {
    
    private var photos = [UnsplashPhoto]()
    
    var delegate: PhotosViewControllerDelegate? {
        didSet {
            getRandomPhotos()
        }
    }
    
    private var timer: Timer?
    
    private let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupCollectionView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        collectionView.frame = self.bounds
    }
    
    private func setupSubviews() {
        addSubview(collectionView)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getRandomPhotos() {
        if let delegate = delegate {
            delegate.loadRandomPhotos { [weak self] randomPhotos in
                self?.photos = randomPhotos
                self?.collectionView.reloadData()
            }
        }
    }
    
}

//MARK: - CollectionView Delegate, DataSource
extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseIdentifier, for: indexPath) as! PhotosCell
        cell.unsplashPhoto = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showNextViewController(photoId: photos[indexPath.item].id,
                                         profileImageUrl: photos[indexPath.item].urls.regular)
    }
}

//MARK: - WaterfallLayoutDelegate
extension PhotosView: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photoWidth = CGFloat(photos[indexPath.item].width)
        let photoHeight = CGFloat(photos[indexPath.item].height)
        let width = self.frame.size.width/2
        let height = photoHeight * width / photoWidth
        return CGSize(width: width, height: height)
    }
}

extension PhotosView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let delegate = delegate else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
            delegate.searchPhoto(by: searchText, completion: { [weak self] searchResults in
                self?.photos = searchResults.results
                self?.collectionView.reloadData()
            })
        })
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if photos.isEmpty {
            getRandomPhotos()
        }
    }
}
