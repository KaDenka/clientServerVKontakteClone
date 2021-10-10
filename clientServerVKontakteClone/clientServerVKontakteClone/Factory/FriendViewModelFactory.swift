//
//  FriendViewModelFactory.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 10.10.2021.
//

import Foundation

import UIKit

class FriendViewModelFactory {
    
    func construct(from friendList: [Friend]) -> [FriendViewModel] {
        return friendList.compactMap { getViewModel(from: $0) }
    }
    
    private func getViewModel(from friend: Friend) -> FriendViewModel {
        let friendName = friend.lastName + " " + friend.firstName
        var friendImage = UIImage()
        if let url = URL(string: friend.photo50) {
                   let data = try? Data(contentsOf: url)
            friendImage = UIImage(data: data!)!
        } else {
            friendImage = UIImage(named: "defaultUserAvatar")!
        }
        
        return FriendViewModel(friendName: friendName, friendImage: friendImage)
    }
    
}
