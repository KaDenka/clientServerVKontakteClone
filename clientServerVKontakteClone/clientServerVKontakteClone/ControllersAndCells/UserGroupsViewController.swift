//
//  UserGroupsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit
//import RealmSwift
//import Firebase
import PromiseKit
import Alamofire


class UserGroupsViewController: UIViewController {
    
    let groupsList = GroupsAPIService()
    
    var groups = [Group]()
    
    // let groupsListRealmDataBase = GroupsDataBase()
    
    // var groupsRealmNotificationToken: NotificationToken?
    
    //let ref = Database.database().reference(withPath: "usersGroups")
    
    @IBOutlet weak var userGroupsTableView: UITableView! {
        didSet {
            userGroupsTableView.delegate = self
            userGroupsTableView.dataSource = self
            userGroupsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "groupCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Usual API request and parsing
        
        //        groupsList.groupsListAPIRequest { [weak self] items in
        //            guard let self = self else { return }
        //
        //            self.groups = items
        
        // MARK: - Realm DataBase services
        
        //self.groupsListRealmDataBase.checkDataAndRenew(array: items)
        // self.groups = self.groupsListRealmDataBase.readData() as [Group] //?? items
        
        // MARK: - Promises functions using
        
        userGroupAPIPromise().then { data in
            
            userGroupDecodeResponsePromise(data: data)
            
        } .done { groups in
            
            self.groups = groups
            self.userGroupsTableView.reloadData()
            
        } .catch { error in
            
            print(error)
            
        }
        
        // self.userGroupsTableView.reloadData()
        
        //self.firebaseLoadingData(users: items)
        //  }
        
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
    
    // MARK: - Realm func
    
    //    func realmChangesTableViewReload() {
    //
    //        let groupsRealmConfiguration = Realm.Configuration(schemaVersion: 1)
    //        let groupsChangesRealm = try! Realm(configuration: groupsRealmConfiguration)
    //
    //        let groups = groupsChangesRealm.objects(Friend.self)
    //
    //        groupsRealmNotificationToken = groups.observe{ [weak self] (changes: RealmCollectionChange) in
    //            guard let tableView = self?.userGroupsTableView else { return }
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
    
    // MARK: - Firebase func
    
    //    func firebaseLoadingData(users: [Group]) {
    //        for group in groups {
    //            let groupForFirebase = GroupRealtimeFirebaseDataModel(groupName: group.name, groupID: group.id)
    //            let groupRef = self.ref.child(groupForFirebase.groupName)
    //            groupRef.setValue(groupForFirebase.toAnyObject())
    //        }
    //    }
}

func userGroupAPIPromise() -> Promise<Data> {
    
    return Promise<Data> { seal in
        
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/groups.get"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
        ]
        let request = URLRequest(url: requestConstructor.url!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return seal.reject(error!)}
            seal.fulfill(data)
        }
        task.resume()
    }
}

func userGroupDecodeResponsePromise(data: Data) -> Promise<[Group]> {
    
    return Promise<[Group]> { seal in
        do { let responseData = try JSONDecoder().decode(UserGroups.self, from: data)
            let groupsList = responseData.response.items
            DispatchQueue.main.async {
                seal.fulfill(groupsList)
            }
            
        } catch {
            seal.reject(error)
        }
    }
}
