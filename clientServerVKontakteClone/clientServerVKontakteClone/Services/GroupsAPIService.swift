//
//  GroupsAPIRequest.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 11.07.2021.
//

import Foundation

class GroupsAPIService {
    func groupsListAPIRequest(complition: @escaping ([Group]) -> (Void) ) {
        DispatchQueue.global().async {
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
                guard let data = data else {return}
                do { let responseData = try JSONDecoder().decode(UserGroups.self, from: data)
                    let groupsList = responseData.response.items
                    DispatchQueue.main.async {
                        complition(groupsList)
                    }
                    
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
