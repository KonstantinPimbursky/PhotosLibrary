//
//  SceneDelegate.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 17.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let tabBarController = MainTabBarController()
            let networkService = UnsplashNetworkService()
            let dataFetcher = UnsplashDataFetcher(networkService: networkService)
            let realmService = RealmDataBaseService()
            let coordinator = MainCoordinator(tabBarController: tabBarController,
                                              unsplashDataFetcher: dataFetcher,
                                              realmService: realmService)
            coordinator.start()
            window.backgroundColor = .white
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

