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
    private let unsplashDataFetcher: NetworkDataFetcher
    private let realmService: RealmService
    
    init(tabBarController: UITabBarController,
         unsplashDataFetcher: NetworkDataFetcher,
         realmService: RealmService) {
        self.tabBarController = tabBarController
        self.unsplashDataFetcher = unsplashDataFetcher
        self.realmService = realmService
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
        
        let photosViewModel = PhotosViewModel(dataFetncher: unsplashDataFetcher)
        let photosCoordinator = ChildCoordinator(navigationController: photosNavigationController,
                                                 dataFetcher: unsplashDataFetcher,
                                                 realmService: realmService)
        let photosViewController = PhotosViewController(coordinator: photosCoordinator, viewModel: photosViewModel)
        
        let favoritesViewModel = FavoritesViewModel(realmService: realmService)
        let favoritesCoordinator = ChildCoordinator(navigationController: favoritesNavigationController,
                                                    dataFetcher: unsplashDataFetcher,
                                                    realmService: realmService)
        let favoritesViewController = FavoritesViewController(coordinator: favoritesCoordinator,
                                                              viewModel: favoritesViewModel)

        photosNavigationController.viewControllers = [photosViewController]
        favoritesNavigationController.viewControllers = [favoritesViewController]
        
        photosCoordinator.delegate = favoritesViewController
        favoritesCoordinator.delegate = favoritesViewController
    }
}
