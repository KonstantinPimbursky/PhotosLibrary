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
        tabBar.isTranslucent = false
        setupViewControllers()
    }
    
    private func setupViewControllers() {
//        let celSize = CGSize(width: (UIScreen.main.bounds.width - 4*8)/3, height: (UIScreen.main.bounds.width - 4*8)/3)
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 8
//        layout.scrollDirection = .vertical
//        layout.itemSize = celSize
        let photosViewController = PhotosViewController()
        
        viewControllers = [
            createNavController(for: photosViewController, title: "Photos", image: UIImage(systemName: "photo.on.rectangle.angled")!),
            createNavController(for: ViewController(), title: "Favourites", image: UIImage(systemName: "heart.fill")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }

}
