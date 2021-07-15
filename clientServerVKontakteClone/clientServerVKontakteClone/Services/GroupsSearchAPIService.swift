//
//  GroupsSearchAPIService.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 11.07.2021.
//

import Foundation

class GroupsSearchAPIService {
    
    var searchingName: String = "Toronto"
    
    func groupsSearchListAPIRequest( complition: @escaping ([SearchedGroup]) -> (Void)) {
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/groups.search"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "q", value: "\(searchingName)"),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
        ]
        let request = URLRequest(url: requestConstructor.url!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do { let responseData = try JSONDecoder().decode(SearchingGroups.self, from: data)
                let searchedGroups = responseData.response.items
                DispatchQueue.main.async {
                    complition(searchedGroups)
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
