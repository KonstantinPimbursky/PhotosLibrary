//
//  MainCoordinator.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 21.10.2021.
//

import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator {
    func showDetailedViewController(photoId: String, profileImageUrl: String) -> Void
}

// MARK: - ReloadData Protocol
protocol ReloadData {
    func reloadData() -> Void
}

// MARK: - MainCoordinator
class MainCoordinator {
    
    private let tabBarController: UITabBarController
    var delegate: ReloadData?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let photosNavigationController = UINavigationController()
        let favoritesNavigationController = UINavigationController()
        
        photosNavigationController.tabBarItem.title = "Photos"
        photosNavigationController.tabBarItem.image = UIImage(systemName: "photo.on.rectangle.angled")
        
        favoritesNavigationController.tabBarItem.title = "Favourites"
        favoritesNavigationController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        tabBarController.viewControllers = [
            photosNavigationController,
            favoritesNavigationController
        ]
        
        let photosCoordinator = ChildCoordinator(navigationController: photosNavigationController)
        let favoritesCoordinator = ChildCoordinator(navigationController: favoritesNavigationController)
        let photosViewController = PhotosViewController(coordinator: photosCoordinator)
        let favoritesViewController = FavoritesViewController(coordinator: favoritesCoordinator)

        photosNavigationController.viewControllers = [photosViewController]
        favoritesNavigationController.viewControllers = [favoritesViewController]
        
        photosCoordinator.delegate = favoritesViewController
        favoritesCoordinator.delegate = favoritesViewController
    }
}
