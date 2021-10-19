//
//  NetworkService.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import Foundation

class NetworkService {
    
    func searchRequest(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareSearchParameters(searchTerm: searchTerm)
        let url = self.searchUrl(parameters: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func photoDetailsRequest(photoId: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = self.getPhotoUrl(photoId: photoId)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func randomPhotoRequest(completion: @escaping (Data?, Error?) -> Void) {
        let url = self.randomPhotoUrl()
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String : String] {
        var headers = [String : String]()
        headers["Authorization"] = "Client-ID wFMT8dBD0de4R1ArL2kJk1zFExDenhpv8rNKch0D9bM"
        return headers
    }
    
    private func prepareSearchParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func searchUrl(parameters: [String : String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        return components.url!
    }
    
    private func getPhotoUrl(photoId: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/\(photoId)"
        return components.url!
    }
    
    private func randomPhotoUrl() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos"
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
