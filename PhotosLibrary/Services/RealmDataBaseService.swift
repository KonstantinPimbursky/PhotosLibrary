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
    @Persisted var userProfileUrl: String
    
    convenience init(id: String,
                     url: String,
                     userName: String,
                     userProfileUrl: String) {
        self.init()
        self.id = id
        self.url = url
        self.userName = userName
        self.userProfileUrl = userProfileUrl
    }
}

// MARK: - Realm Service
class RealmDataBaseService {
    
    private let localRealm = try! Realm()
    
    func savePhoto(id: String, url: String, userName: String, userProfileUrl: String) {
        let photo = PhotoRealmObject(id: id, url: url, userName: userName, userProfileUrl: userProfileUrl)
        try! localRealm.write {
            localRealm.add(photo)
        }
    }
    
    func getSavedPhotos() -> [PhotoRealmObject] {
        let savedPhotos = localRealm.objects(PhotoRealmObject.self).toArray()
        return savedPhotos
    }
    
    func deletePhoto(id: String) {
        let savedPhotos = localRealm.objects(PhotoRealmObject.self)
        let predicate = NSPredicate(format: "id == %@", id)
        let findPhoto = savedPhotos.filter(predicate)
        try! localRealm.write {
            localRealm.delete(findPhoto)
        }
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
