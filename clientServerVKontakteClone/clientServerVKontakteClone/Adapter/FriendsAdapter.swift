//
//  FriendsAdapter.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 30.09.2021.
//https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131

import Foundation

class FriendsAdapter {
    
    private let friendAPI = FriendsAPIService()
    
    private var friendsList = [Friend]()
    
    func getFriendsList(completion: ([Friend]) -> Void) {
        friendAPI.friendsListAPIRequest { [weak self] friends in
            guard let self = self else { return }
            self.friendsList = friends
        }
        
        completion(friendsList)
    }
}
