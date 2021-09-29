//
//  FriendsOperationAPIService.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 26.08.2021.
//

import Foundation

class FriendsMakeAPIDataOperation: Operation {
    var data: Data?
    
    override func main() {
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/friends.get"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50,online"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
        ]
        guard let url = requestConstructor.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.data = data
    }
}

class FriendsParsingOperation: Operation {
    var friendsList: [Friend]? = []
    
    override func main() {
        guard let friendsListData = dependencies.first as? FriendsMakeAPIDataOperation,
              let data = friendsListData.data else { return }
        
        do {
            let responseData = try JSONDecoder().decode(Friends.self, from: data)
            self.friendsList = responseData.response.items
        } catch {
            print(error)
        }
    }
}

class FriendsDiaplayOperation: Operation {
    var friendsViewController: FriendsViewController
    
    override func main() {
        guard let parsedFriendsListData = dependencies.first as? FriendsParsingOperation,
              let friendsList = parsedFriendsListData.friendsList else { return }
        friendsViewController.friends = friendsList
        friendsViewController.friendsTableView.reloadData()
    }
    
    init(controller: FriendsViewController) {
        self.friendsViewController = controller
    }
}
