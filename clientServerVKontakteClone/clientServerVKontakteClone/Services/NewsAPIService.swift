//
//  NewsAPIService.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 08.08.2021.
//

import Foundation

class NewsAPIService {
    
    func newsAPIRequest(complition: @escaping ([ResponseItem], [Profile], [NewsGroup]) -> (Void)) {
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/newsfeed.get"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
        ]
        let request = URLRequest(url: requestConstructor.url!)
        
        //print("NEWS REQUEST: \(request)")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {return}
            do { let responseData = try JSONDecoder().decode(News.self, from: data)
                let responseItems = responseData.response?.items
                let profiles = responseData.response?.profiles
                let newsGroups = responseData.response?.groups
                            DispatchQueue.main.async {
                                complition(responseItems ?? [ResponseItem](), profiles ?? [Profile](), newsGroups ?? [NewsGroup]())
                            }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
