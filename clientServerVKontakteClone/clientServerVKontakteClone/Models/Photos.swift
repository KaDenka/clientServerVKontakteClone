//
//  Photos.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import Foundation


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

class Photo: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let sizes: [Size]
    let text: String
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text, lat, long
    }

    init(albumID: Int, date: Int, id: Int, ownerID: Int, hasTags: Bool, sizes: [Size], text: String, lat: Double?, long: Double?) {
        self.albumID = albumID
        self.date = date
        self.id = id
        self.ownerID = ownerID
        self.hasTags = hasTags
        self.sizes = sizes
        self.text = text
        self.lat = lat
        self.long = long
    }
}

class Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int

    init(height: Int, url: String, type: String, width: Int) {
        self.height = height
        self.url = url
        self.type = type
        self.width = width
    }
}
