//
//  FriendsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit
//import RealmSwift
//import Firebase

class FriendsViewController: UIViewController {
    
    //let friendsList = FriendsAPIService()
    
    var friends = [Friend]()
    
    let friendsAdapter = FriendsAdapter()
    
    //let friendsListRealmDataBase = FriendsDataBase()
    
   // var friendsRealmToken: NotificationToken?
    
   // let ref = Database.database().reference(withPath: "usersID")
    
    @IBOutlet weak var friendsTableView: UITableView! {
        didSet {
            friendsTableView.delegate = self
            friendsTableView.dataSource = self
            friendsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "friendsTableViewCell")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        
        
// MARK: - The loading table view data way 1 (normal)
        
//        friendsList.friendsListAPIRequest { [weak self] items in
//            guard let self = self else { return }
//            self.friends = items
//
//            //self.friendsListRealmDataBase.checkDataAndRenew(array: items)
//           // self.friends = self.friendsListRealmDataBase.readData() as [Friend] //?? items
//
//            self.friendsTableView.reloadData()
//
//           // self.firebaseLoadingData(users: items)
//        }
//        // realmChangesTableViewReload()
//
        
        
// MARK: - The loading table view data way 2 (through Operation)
        
//        let operationsQueue = OperationQueue()
//
//        let friendsMakeAPIDataOperation = FriendsMakeAPIDataOperation()
//        let friendsParsingOperation = FriendsParsingOperation()
//        let friendsDiaplayOperation = FriendsDiaplayOperation(controller: self)
//
//        operationsQueue.addOperation(friendsMakeAPIDataOperation)
//        friendsParsingOperation.addDependency(friendsMakeAPIDataOperation)
//        operationsQueue.addOperation(friendsParsingOperation)
//        friendsDiaplayOperation.addDependency(friendsParsingOperation)
//        OperationQueue.main.addOperation(friendsDiaplayOperation)
//
// MARK: - The loading data via Adapter
        friendsAdapter.getFriendsList { [weak self] receivedFriends in
            guard let self = self else { return }
            self.friends = receivedFriends
            self.friendsTableView.reloadData()
        }
        
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
            if let imageView = cell.imageView {
                imageView.image = image
                imageView.layer.cornerRadius = (imageView.image?.size.height)! / 2.25
                imageView.clipsToBounds = true
            }
        }
        
        
        
        return cell
    }
    
//    func realmChangesTableViewReload() {
//        
//        let friendsRealmConfiguration = Realm.Configuration(schemaVersion: 3)
//        let friendsChangesRealm = try! Realm(configuration: friendsRealmConfiguration)
//        
//        let friends = friendsChangesRealm.objects(Friend.self)
//        
//        friendsRealmToken = friends.observe{ [weak self] (changes: RealmCollectionChange) in
//            guard let tableView = self?.friendsTableView else { return }
//            
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                
//                tableView.beginUpdates()
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                tableView.endUpdates()
//            case .error(let error):
//                print(error.localizedDescription)
//            }
//            
//        }
//        
//    }
    
//    func firebaseLoadingData(users: [Friend]) {
//        for user in users {
//            let userForFirebase = UserIDRealtimeFirebaseDataModel(userName: (user.lastName + user.firstName), userID: user.id)
//            let userRef = self.ref.child(userForFirebase.userName)
//            userRef.setValue(userForFirebase.toAnyObject())
//        }
//    }
}
