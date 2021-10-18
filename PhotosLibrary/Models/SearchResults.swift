//
//  SearchResults.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import Foundation

struct SearchResults: Codable {
    let total: Int
    let results: [Results]
}

struct Results: Codable {
    let width: Int
    let height: Int
    let urls: Urls
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
