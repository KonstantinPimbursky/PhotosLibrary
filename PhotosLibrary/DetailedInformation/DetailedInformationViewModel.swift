//
//  DetailedInformationViewModel.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 23.10.2021.
//

import Foundation

protocol DetailedInformationInput {
    func getDetailsOfPhoto(completion: @escaping (PhotoDetails?) -> Void) -> Void
    func savePhoto() -> Void
    func deletePhoto() -> Void
    func getSavedPhotos() -> [PhotoRealmObject]
    func getProfileImageUrl() -> String
}

class DetailedInformationViewModel: DetailedInformationInput {
    
    private let realmService: RealmService
    private let dataFetcher: NetworkDataFetcher
    private let photoId: String
    private let profileImageUrl: String
    private var photoDetails: PhotoDetails?
    var delegate: ReloadData?
    
    init(realmService: RealmService,
         dataFetcher: NetworkDataFetcher,
         photoId: String,
         profileImageUrl: String) {
        self.dataFetcher = dataFetcher
        self.realmService = realmService
        self.photoId = photoId
        self.profileImageUrl = profileImageUrl
    }
    
    func getDetailsOfPhoto(completion: @escaping (PhotoDetails?) -> Void) {
        dataFetcher.fetchPhotoDetails(photoId: photoId) { [weak self] photo in
            self?.photoDetails = photo
            completion(photo)
        }
    }
    
    func savePhoto() {
        guard let photo = photoDetails else { return }
        guard let delegate = delegate else { return }
        realmService.savePhoto(id: photo.id,
                               url: photo.urls.small,
                               userName: photo.user.name,
                               userProfileUrl: profileImageUrl)
        delegate.reloadData()
    }
    
    func deletePhoto() {
        guard let photo = photoDetails else { return }
        guard let delegate = delegate else { return }
        realmService.deletePhoto(id: photo.id)
        delegate.reloadData()
    }
    
    func getSavedPhotos() -> [PhotoRealmObject] {
        return realmService.getSavedPhotos()
    }
    
    func getProfileImageUrl() -> String {
        return profileImageUrl
    }
}
