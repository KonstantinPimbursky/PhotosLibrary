//
//  PhotosViewController.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 17.10.2021.
//

import UIKit

protocol PhotosViewControllerDelegate {
    func showNextViewController(photoId: String, profileImageUrl: String) -> Void
    func loadRandomPhotos(completion: @escaping ([UnsplashPhoto]) -> Void)
    func searchPhoto(by searchText: String, completion: @escaping (SearchResults) -> Void) -> Void
}

class PhotosViewController: UIViewController {
    
    //MARK: - Properties
    private let viewModel: PhotosViewInput
    private let coordinator: Coordinator
    
    //MARK: - Init
    init(coordinator: Coordinator,
         viewModel: PhotosViewInput) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        setupNavigationController()
        setupSearchBar()
    }
    
    override func loadView() {
        let photosView = PhotosView()
        photosView.delegate = self
        self.view = photosView
    }
    
    private func setupNavigationController() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = view()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func view() -> PhotosView {
        return self.view as! PhotosView
    }
}

// MARK: - PhotosViewControllerDelegate

extension PhotosViewController: PhotosViewControllerDelegate {
    func searchPhoto(by searchText: String, completion: @escaping (SearchResults) -> Void) {
        self.viewModel.searchPhotos(by: searchText, completion: completion)
    }
    
    func showNextViewController(photoId: String, profileImageUrl: String) {
        coordinator.showDetailedViewController(photoId: photoId,
                                               profileImageUrl: profileImageUrl)
    }
    
    func loadRandomPhotos(completion: @escaping ([UnsplashPhoto]) -> Void) {
        viewModel.getRandomPhotos(completion: completion)
    }
}
