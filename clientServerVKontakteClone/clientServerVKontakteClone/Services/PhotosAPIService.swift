//
//  PhotosAPIRequest.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 11.07.2021.
//

import Foundation

class PhotosAPIService {
    func photosListAPIRequest( complition: @escaping ([Photo]) -> (Void) ) {
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/photos.get"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
        ]
        let request = URLRequest(url: requestConstructor.url!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do { let responseData = try JSONDecoder().decode(Photos.self, from: data)
                let photoCollection = responseData.response.items
                DispatchQueue.main.async {
                    complition(photoCollection)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
