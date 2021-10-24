//
//  PhotosCoordinator.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 22.10.2021.
//

import UIKit

class ChildCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let dataFetcher: NetworkDataFetcher
    private let realmService: RealmService
    var delegate: ReloadData?
    
    init(navigationController: UINavigationController,
         dataFetcher: NetworkDataFetcher,
         realmService: RealmService) {
        self.navigationController = navigationController
        self.dataFetcher = dataFetcher
        self.realmService = realmService
    }
    
    func showDetailedViewController(photoId: String, profileImageUrl: String) {
        let viewModel = DetailedInformationViewModel(realmService: realmService,
                                                     dataFetcher: dataFetcher,
                                                     photoId: photoId,
                                                     profileImageUrl: profileImageUrl)
        viewModel.delegate = delegate
        let detailedViewController = DetailedInformationViewController(viewModel: viewModel)
        navigationController.pushViewController(detailedViewController, animated: true)
    }
}
