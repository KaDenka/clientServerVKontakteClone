//
//  UserGroupsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit
import RealmSwift
import Firebase

class UserGroupsViewController: UIViewController {
    
    let groupsList = GroupsAPIService()
    
    var groups = [Group]()
    
    let groupsListRealmDataBase = GroupsDataBase()
    
    var groupsRealmNotificationToken: NotificationToken?
    
    let ref = Database.database().reference(withPath: "usersGroups")

    @IBOutlet weak var userGroupsTableView: UITableView! {
        didSet {
            userGroupsTableView.delegate = self
            userGroupsTableView.dataSource = self
            userGroupsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "groupCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsList.groupsListAPIRequest { [weak self] items in
            guard let self = self else { return }
            self.groupsListRealmDataBase.checkDataAndRenew(array: items)
            self.groups = self.groupsListRealmDataBase.readData() as [Group] //?? items
            self.userGroupsTableView.reloadData()
            
            self.firebaseLoadingData(users: items)
        }
        
     //   realmChangesTableViewReload()

    }

}

extension UserGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = groups[indexPath.row]
        cell.textLabel?.text = "\(group.name)"
        if let url = URL(string: group.photo200) {
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)
            cell.imageView?.image = image
        }
        return cell
    }
    
    func realmChangesTableViewReload() {
        
        let groupsRealmConfiguration = Realm.Configuration(schemaVersion: 1)
        let groupsChangesRealm = try! Realm(configuration: groupsRealmConfiguration)
        
        let groups = groupsChangesRealm.objects(Friend.self)
        
        groupsRealmNotificationToken = groups.observe{ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.userGroupsTableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    func firebaseLoadingData(users: [Group]) {
        for group in groups {
            let groupForFirebase = GroupRealtimeFirebaseDataModel(groupName: group.name, groupID: group.id)
            let groupRef = self.ref.child(groupForFirebase.groupName)
            groupRef.setValue(groupForFirebase.toAnyObject())
        }
    }
    
}
