//
//  PhotosViewModel.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 23.10.2021.
//

import Foundation

protocol PhotosViewInput {
    func getRandomPhotos(completion: @escaping ([UnsplashPhoto]) -> Void)
    func searchPhotos(by searchWord: String, completion: @escaping (SearchResults) -> Void)
}

class PhotosViewModel: PhotosViewInput {
    
    private let dataFetcher: NetworkDataFetcher
    
    init(dataFetncher: NetworkDataFetcher) {
        self.dataFetcher = dataFetncher
    }
    
    func getRandomPhotos(completion: @escaping ([UnsplashPhoto]) -> Void) {
        dataFetcher.fetchRandomPhotos { randomPhotos in
            guard let fetchedPhotos = randomPhotos else { return }
            completion(fetchedPhotos)
        }
    }
    
    func searchPhotos(by searchWord: String, completion: @escaping (SearchResults) -> Void) {
        dataFetcher.fetchImages(searchTerm: searchWord) { searchResults in
            guard let fetchedPhotos = searchResults else { return }
            completion(fetchedPhotos)
        }
    }
    
    
}
