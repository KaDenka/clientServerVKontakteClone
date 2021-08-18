//
//  FriendsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    let friendsList = FriendsAPIService()
    
    var friends = [Friend]()
    
    let friendsListRealmDataBase = FriendsDataBase()
    
    var friendsRealmToken: NotificationToken?
    
    @IBOutlet weak var friendsTableView: UITableView! {
        didSet {
            friendsTableView.delegate = self
            friendsTableView.dataSource = self
            friendsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "friendsTableViewCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsList.friendsListAPIRequest { [weak self] items in
            guard let self = self else { return }
            self.friendsListRealmDataBase.checkDataAndRenew(array: items)
            self.friends = self.friendsListRealmDataBase.readData() as [Friend] //?? items
            self.friendsTableView.reloadData()
        }
        
     // realmChangesTableViewReload()
        
    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsTableViewCell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        if let url = URL(string: friend.photo50) {
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)
            cell.imageView?.image = image
        }
        return cell
    }
    
    func realmChangesTableViewReload() {
        
        let friendsRealmConfiguration = Realm.Configuration(schemaVersion: 3)
        let friendsChangesRealm = try! Realm(configuration: friendsRealmConfiguration)
        
        let friends = friendsChangesRealm.objects(Friend.self)
        
        friendsRealmToken = friends.observe{ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.friendsTableView else { return }
            
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
}
