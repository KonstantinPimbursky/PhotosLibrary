//
//  RealmDataBaseService.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 20.10.2021.
//

import Foundation
import RealmSwift

// MARK: - Realm Object
class PhotoRealmObject: Object {
    @Persisted var id: String
    @Persisted var url: String
    @Persisted var userName: String
    
    convenience init(id: String,
                     url: String,
                     userName: String) {
        self.init()
        self.id = id
        self.url = url
        self.userName = userName
    }
}

// MARK: - Realm Service
class RealmDataBaseService {
    
    private let localRealm = try! Realm()
    
    func savePhoto(id: String, url: String, userName: String) {
        let photo = PhotoRealmObject(id: id, url: url, userName: userName)
        try! localRealm.write {
            localRealm.add(photo)
        }
    }
    
    func getSavedPhotos() -> [PhotoRealmObject] {
        let savedPhotos = localRealm.objects(PhotoRealmObject.self).toArray()
        return savedPhotos
    }
    
}

// MARK: - Results Extension
extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
