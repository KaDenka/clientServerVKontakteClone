//
//  DataBaseProtocol.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 28.07.2021.
//

import Foundation
import RealmSwift

protocol DataBaseProtocol {
    
    associatedtype T
    
    func addData(model: T)
    
    func readData() -> [T]
    
    func deleteData(model: T)
    
    func checkDataAndRenew(array: [T])
    
}
