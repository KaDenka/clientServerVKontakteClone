//
//  APIServiceInterface.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 21.10.2021.
//

import Foundation

protocol APIServiceInterface {
    func friendsListAPIRequest(completion: @escaping ([Friend]) -> (Void))
}
