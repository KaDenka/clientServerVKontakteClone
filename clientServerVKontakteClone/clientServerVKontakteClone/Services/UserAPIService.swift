//
//  UserAPIService.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 29.08.2021.
//

import Foundation

class UserAPIService {
    func userProfileAPIRequest(complition: @escaping ([UserResponse]) -> (Void)) {
        DispatchQueue.global().async {
            var requestConstructor = URLComponents()
            requestConstructor.scheme = "https"
            requestConstructor.host = "api.vk.com"
            requestConstructor.path = "/method/users.get"
            requestConstructor.queryItems = [
                URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
                URLQueryItem(name: "name_case", value: "nom"),
                URLQueryItem(name: "fields", value: "photo_200"),
                URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
                URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
            ]
            let request = URLRequest(url: requestConstructor.url!)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                guard let data = data else {return}
                do { let responseData = try JSONDecoder().decode(User.self, from: data)
                    let userProfile = responseData.response
                    DispatchQueue.main.async {
                        complition(userProfile)
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
