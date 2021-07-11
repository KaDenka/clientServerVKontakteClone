//
//  ViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 06.07.2021.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    let friendsList = FriendsAPIService()
    let photosList = PhotosAPIService()
    let groupsList = GroupsAPIService()
    let groupsSearchList = GroupsSearchAPIService()
    
    @IBOutlet weak var authWebView: WKWebView! {
        didSet {
            authWebView.navigationDelegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var constructorURL = URLComponents()
        
        constructorURL.scheme = "https"
        constructorURL.host = "oauth.vk.com"
        constructorURL.path = "/authorize"
        constructorURL.queryItems = [
            URLQueryItem(name: "client_id", value: "7900166"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,groups,photos,offline"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
        ]
        let request = URLRequest(url: constructorURL.url!)
        
        authWebView.load(request)
       
    }
    
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse:
                    WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let
                responseFragments = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        let authParams = responseFragments
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let authTokenResponse = authParams["access_token"], let authUserIdResponse = authParams["user_id"] else {return}
        Session.shared.token = authTokenResponse
        Session.shared.userId = Int(authUserIdResponse)!
        
        //print("CONTROL RESPONSE DATA: token = \(Session.shared.token), userId = \(Session.shared.userId)")
        
        friendsList.friendsListAPIRequest()
        photosList.photosListAPIRequest()
        groupsList.groupsListAPIRequest()
        groupsSearchList.groupsSearchListAPIRequest()
        
        decisionHandler(.cancel)
    }
    
}
