//
//  User.swift
//  FirestoreApp
//
//  Created by developersancho on 16.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String? { get set }
}

struct User: Codable, Identifiable {
    var id: String? = nil
    let name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
