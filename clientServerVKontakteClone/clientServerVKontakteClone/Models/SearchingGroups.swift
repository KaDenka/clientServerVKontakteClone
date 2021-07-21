//
//  SearchingGroups.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import Foundation
import RealmSwift

class SearchingGroups: Codable {
    let response: SearchResponse
    
    init(response: SearchResponse) {
        self.response = response
    }
}


class SearchResponse: Codable {
    let count: Int
    let items: [SearchedGroup]
    
    init(count: Int, items: [SearchedGroup]) {
        self.count = count
        self.items = items
    }
}


class SearchedGroup: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

