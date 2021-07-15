//
//  FriendsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit

class FriendsViewController: UIViewController {
    
    let friendsList = FriendsAPIService()
    
    var friends = [Friend]()
    
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
            self.friends = items
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
            cell.imageView?.image = image
        }
        return cell
    }
}
