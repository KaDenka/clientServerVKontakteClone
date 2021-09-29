//
//  FriendsAPIRequest.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 11.07.2021.
//

//https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131

import Foundation

class FriendsAPIService {
    
    func friendsListAPIRequest(complition: @escaping ([Friend]) -> (Void)) {
        DispatchQueue.global().async {
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
            let request = URLRequest(url: requestConstructor.url!)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                guard let data = data else {return}
                do { let responseData = try JSONDecoder().decode(Friends.self, from: data)
                    let friendsList = responseData.response.items
                    DispatchQueue.main.async {
                        complition(friendsList)
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
