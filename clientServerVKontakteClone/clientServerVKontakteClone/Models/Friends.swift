//
//  FriendModel.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import Foundation
//import RealmSwift

class Friends: Codable {
    let response: Response

    init(response: Response) {
        self.response = response
    }
}

class Response: Codable {
    let count: Int
    let items: [Friend]

    init(count: Int, items: [Friend]) {
        self.count = count
        self.items = items
    }
}

class Friend: /*Object,*/ Codable {
    /*@objc dynamic */ var firstName: String = ""
    /*@objc dynamic */ var id: Int = 0
    /*@objc dynamic */ var lastName: String = ""
    /*@objc dynamic */ var photo50: String = ""

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
    
    //override static func primaryKey() -> String? { return "id"}
}
