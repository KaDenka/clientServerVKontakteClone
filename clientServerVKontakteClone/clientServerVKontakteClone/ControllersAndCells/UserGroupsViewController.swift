//
//  UserGroupsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit

class UserGroupsViewController: UIViewController {
    
    let groupsList = GroupsAPIService()
    
    var groups = [Group]()

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
            self.groups = items
            self.userGroupsTableView.reloadData()
        }

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
}
