//
//  Session.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 06.07.2021.
//

import Foundation

// MARK: - Singletone Session

final class Session {
    static let shared = Session()
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    var versionVK: String = "5.131"
}
