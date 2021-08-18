//
//  UserIDRealtimeFirebaseDataModel.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 03.08.2021.
//

import Foundation
import Firebase

class UserIDRealtimeFirebaseDataModel {
    let userName: String
    let userID: Int
    let ref: DatabaseReference?
    
    init(userName: String, userID: Int) {
        self.userName = userName
        self.userID = userID
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let userName = value["userName"] as? String,
              let userID = value["userID"] as? Int
        else { return nil }
        
        self.ref = snapshot.ref
        self.userName = userName
        self.userID = userID
    }
    
    func toAnyObject() -> [AnyHashable: Any] {
        return ["userName": userName,
                "userID": userID] as [AnyHashable: Any]
    }
}

class GroupRealtimeFirebaseDataModel {
    let groupName: String
    let groupID: Int
    let ref: DatabaseReference?
    
    init(groupName: String, groupID: Int) {
        self.groupName = groupName
        self.groupID = groupID
        self.ref = nil
    }

    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let groupName = value["groupName"] as? String,
              let groupID = value["groupID"] as? Int
        else { return nil }
        
        self.ref = snapshot.ref
        self.groupName = groupName
        self.groupID = groupID
    }

    func toAnyObject() -> [AnyHashable: Any] {
        return ["groupName": groupName,
                "groupID": groupID] as [AnyHashable: Any]
    }
}
