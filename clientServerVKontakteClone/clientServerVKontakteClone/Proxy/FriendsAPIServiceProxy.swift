//
//  FriendsAPIServiceProxy.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 21.10.2021.
//

import Foundation

class FriendsAPIServiceProxy: APIServiceInterface {
    
    let friendsAPI: APIServiceInterface
    
    let serviceRequested = "Запрос списка друзей произведен"
    
    init(friendsAPI: APIServiceInterface) {
        self.friendsAPI = friendsAPI
    }
    
    func friendsListAPIRequest(completion: @escaping ([Friend]) -> (Void)) {
        friendsAPI.friendsListAPIRequest { [self] friends in
            print(serviceRequested)
            completion(friends)
        }
    }
}
