//
//  FriendsDataBase.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 27.07.2021.
//

import Foundation
import RealmSwift

class FriendsDataBase: DataBaseProtocol {
    
    let friendsRealmConfiguration = Realm.Configuration(schemaVersion: 3)
    lazy var friendsRealm = try! Realm(configuration: friendsRealmConfiguration)
    
    func addData(model: Friend) {
        
            friendsRealm.beginWrite()
            friendsRealm.add(model)
            try! friendsRealm.commitWrite()

    }
    
    func readData() -> [Friend] {
        
        var friends = [Friend]()
        let realmFriends = friendsRealm.objects(Friend.self)
        
        for friend in realmFriends {
            friends.append(friend)
        }
        
        return friends
    }
    
    func deleteData(model: Friend) {
        friendsRealm.beginWrite()
        friendsRealm.delete(model)
        
    }
    
    func checkDataAndRenew(array: [Friend]){
        let savedFriendsList = readData()
        if array != savedFriendsList {
            for friend in savedFriendsList {
                deleteData(model: friend)
            }
            
            for model in array {
                addData(model: model)
            }
        }
        guard let realmURL = friendsRealm.configuration.fileURL else { return print("NO ANY REALM URL")}
        print("REALM FILE: \(realmURL)")
    }
}
