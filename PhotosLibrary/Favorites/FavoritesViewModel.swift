//
//  FavoritesViewModel.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 24.10.2021.
//

import Foundation

protocol FavoritesViewInput {
    func getSavedPhotos() -> [PhotoRealmObject]
}

class FavoritesViewModel: FavoritesViewInput {
    
    private let realmService: RealmService
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func getSavedPhotos() -> [PhotoRealmObject] {
        return realmService.getSavedPhotos()
    }
}
