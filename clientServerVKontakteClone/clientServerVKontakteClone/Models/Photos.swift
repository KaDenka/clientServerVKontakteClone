//
//  Photos.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import Foundation
import RealmSwift


class Photos: Codable {
    let response: ItemsCollection

    init(response: ItemsCollection) {
        self.response = response
    }
}

class ItemsCollection: Codable {
    let count: Int
    let items: [Photo]

    init(count: Int, items: [Photo]) {
        self.count = count
        self.items = items
    }
}

class Photo: Object, Codable {
    @objc dynamic var albumID: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int
    var sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes
    }
}

class Size: Object, Codable {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var width: Int = 0
}
