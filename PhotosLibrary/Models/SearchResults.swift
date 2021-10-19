//
//  SearchResults.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import Foundation

struct SearchResults: Codable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Codable {
    let width: Int
    let height: Int
    let id: String
    let urls: Urls
    let user: UserInformation
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

struct UserInformation: Codable {
    let id: String
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small: String
}
