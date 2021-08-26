//
//  RealmSwiftExtension.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 28.07.2021.
//
//
//import Foundation
//import RealmSwift
//
//extension Realm {
//    public func safeWrite(_ block: (() throws -> Void)) throws {
//        if isInWriteTransaction {
//            try block()
//        } else {
//            try write(block)
//        }
//    }
//}
