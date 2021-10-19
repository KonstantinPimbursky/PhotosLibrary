//
//  PhotoDetails.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import Foundation

struct PhotoDetails: Codable {
    let id: String
    let createdAt: String
    let downloads: Int
    let location: Location
    let user: User
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case downloads
        case location
        case user
        case urls
    }
}

struct Location: Codable {
    let city: String?
    let country: String?
}

struct User: Codable {
    let name: String
}
