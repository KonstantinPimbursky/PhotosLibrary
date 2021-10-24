//
//  NetworkDataFetcher.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import Foundation

protocol NetworkDataFetcher {
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> Void)
    func fetchPhotoDetails(photoId: String, completion: @escaping (PhotoDetails?) -> Void)
    func fetchRandomPhotos(completion: @escaping ([UnsplashPhoto]?) -> Void)
}

class UnsplashDataFetcher: NetworkDataFetcher {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> Void) {
        networkService.searchRequest(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error recieved requesting data: \(error)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func fetchPhotoDetails(photoId: String, completion: @escaping (PhotoDetails?) -> Void) {
        networkService.photoDetailsRequest(photoId: photoId) { (data, error) in
            if let error = error {
                print("Error recieved requesting data: \(error)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: PhotoDetails.self, from: data)
            completion(decode)
        }
    }
    
    func fetchRandomPhotos(completion: @escaping ([UnsplashPhoto]?) -> Void) {
        networkService.randomPhotoRequest() { (data, error) in
            if let error = error {
                print("Error recieved requesting data: \(error)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: [UnsplashPhoto].self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
}
