//
//  File.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 29.08.2021.
//

import Foundation

// MARK: - User
class User: Codable {
    let response: [UserResponse]

    init(response: [UserResponse]) {
        self.response = response
    }
}

// MARK: - UserResponse
class UserResponse: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo200: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo200 = "photo_200"
    }

    init(firstName: String, id: Int, lastName: String, photo200: String) {
        self.firstName = firstName
        self.id = id
        self.lastName = lastName
        self.photo200 = photo200
    }
}


