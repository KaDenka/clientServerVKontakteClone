//
//  FriendModel.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import Foundation

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

class Friend: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let canAccessClosed, isClosed: Bool
    let photo50: String
    let online: Int
    let trackCode: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case photo50 = "photo_50"
        case online
        case trackCode = "track_code"
    }

    init(firstName: String, id: Int, lastName: String, canAccessClosed: Bool, isClosed: Bool, photo50: String, online: Int, trackCode: String) {
        self.firstName = firstName
        self.id = id
        self.lastName = lastName
        self.canAccessClosed = canAccessClosed
        self.isClosed = isClosed
        self.photo50 = photo50
        self.online = online
        self.trackCode = trackCode
    }
}
