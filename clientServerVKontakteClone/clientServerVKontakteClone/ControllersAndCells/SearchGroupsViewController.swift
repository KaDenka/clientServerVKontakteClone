//
//  SearchGroupsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit

class SearchGroupsViewController: UIViewController {
    
    let groupsSearchList = GroupsSearchAPIService()
    
    var groups = [SearchedGroup]()
    
    @IBOutlet weak var groupsSearchBar: UISearchBar!
    
    @IBOutlet weak var searchGroupsTableView: UITableView! {
        didSet {
            searchGroupsTableView.delegate = self
            searchGroupsTableView.dataSource = self
            searchGroupsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchedGroupCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func searchGroupsButton(_ sender: UIButton) {
        
        groupsSearchList.groupsSearchListAPIRequest(groupName: self.groupsSearchBar.text ?? "") { [weak self] item in
            guard let self = self else { return }
            self.groups = item
            self.searchGroupsTableView.reloadData()
        }
        self.groupsSearchBar.text = nil
    }
    
}

extension SearchGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedGroupCell", for: indexPath)
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
