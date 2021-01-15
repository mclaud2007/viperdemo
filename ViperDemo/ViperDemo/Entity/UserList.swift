//
//  UserList.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import Foundation

class UserList {
    var users: [User]?
    
    init(from json: [[String: Any]]) {
        self.users = json.compactMap { User(JSON: $0) }
    }
}
