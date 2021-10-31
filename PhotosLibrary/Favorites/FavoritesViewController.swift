//
//  FavoritesViewController.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 20.10.2021.
//

import UIKit

protocol FavoritesViewControllerDelegate {
    func showNextViewController(photoId: String, profileImageUrl: String) -> Void
    func loadData() -> [PhotoRealmObject]
}

class FavoritesViewController: UIViewController {
    // MARK: - Properties
    private let coordinator: Coordinator
    private let viewModel: FavoritesViewInput
    
    // MARK: - Init
    init(coordinator: Coordinator,
         viewModel: FavoritesViewInput) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    override func loadView() {
        let favoritiesView = FavoritesView()
        favoritiesView.delegate = self
        self.view = favoritiesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func view() -> FavoritesView {
        return self.view as! FavoritesView
    }
}

// MARK: - Extensions
extension FavoritesViewController: ReloadData {
    func reloadData() {
        view().reloadData()
    }
}

extension FavoritesViewController: FavoritesViewControllerDelegate {
    func loadData() -> [PhotoRealmObject] {
        return viewModel.getSavedPhotos()
    }
    
    func showNextViewController(photoId: String, profileImageUrl: String) {
        coordinator.showDetailedViewController(photoId: photoId,
                                               profileImageUrl: profileImageUrl)
    }
}
