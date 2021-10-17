//
//  MainTabBarController.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 17.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            createNavController(for: ViewController(), title: "Photos", image: UIImage(systemName: "photo.on.rectangle.angled")!),
            createNavController(for: ViewController(), title: "Favourites", image: UIImage(systemName: "heart.fill")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }

}
