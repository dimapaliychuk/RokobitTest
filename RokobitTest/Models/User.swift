//
//  User.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Foundation
import RealmSwift

class UserResponse: Codable {
    
    var user: User
    
    
    // compiler generated
    private enum CodingKeys: String, CodingKey {
        case user = "data"
    }
}

class User: Object, Codable {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var avatarURL: String?
    
    
    // compiler generated
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "avatar"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
