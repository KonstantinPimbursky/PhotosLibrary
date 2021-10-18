//
//  NetworkDataFetcher.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> Void) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error recieved requesting data: \(error)")
                completion(nil)
            }
            let decode = self.decodeJSON(from: data)
            completion(decode)
        }
    }
    
    func decodeJSON(from: Data?) -> SearchResults? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let object = try decoder.decode(SearchResults.self, from: data)
            return object
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
}
