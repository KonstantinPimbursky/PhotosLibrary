//
//  PhotosCoordinator.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 22.10.2021.
//

import UIKit

class ChildCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var delegate: ReloadData?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showDetailedViewController(photoId: String, profileImageUrl: String) {
        let detailedViewController = DetailedInformationViewController(photoId: photoId, profileImageUrl: profileImageUrl)
        detailedViewController.delegate = delegate
        navigationController.pushViewController(detailedViewController, animated: true)
    }
    
    
}
