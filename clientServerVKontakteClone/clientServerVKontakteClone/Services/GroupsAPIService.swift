//
//  GroupsAPIRequest.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 11.07.2021.
//

import Foundation

class GroupsAPIService {
    func groupsListAPIRequest() {
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
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
           print("GROUPS = \(json!)")
        }
        task.resume()
    }
}
