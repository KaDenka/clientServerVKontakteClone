//
//  GroupsDataBase.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 28.07.2021.
//

import Foundation
import RealmSwift

class GroupsDataBase: DataBaseProtocol {
    
    let groupsRealmConfiguration = Realm.Configuration(schemaVersion: 1)
    lazy var groupsRealm = try! Realm(configuration: groupsRealmConfiguration)
    
    func addData(model: Group) {
        
        groupsRealm.beginWrite()
        groupsRealm.add(model)
        try! groupsRealm.commitWrite()
        
    }
    
    func readData() -> [Group] {
        
        var groups = [Group]()
        let realmGroups = groupsRealm.objects(Group.self)
        
        for group in realmGroups {
            groups.append(group)
        }
        
        return groups
    }
    
    func deleteData(model: Group) {
        groupsRealm.beginWrite()
        groupsRealm.delete(model)
        try! groupsRealm.commitWrite()
        
    }
    
    func checkDataAndRenew(array: [Group]){
        let savedGroupsList = readData()
        if array != savedGroupsList {
            for group in savedGroupsList {
                deleteData(model: group)
            }
            
            for model in array {
                addData(model: model)
            }
        }
        //guard let realmURL = groupsRealm.configuration.fileURL else { return print("NO ANY REALM URL")}
        //print("GROUPS REALM FILE: \(realmURL)")
    }
}

