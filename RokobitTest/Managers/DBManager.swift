//
//  DBManager.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    
    private var database : Realm
    static let shared = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getUserFromDB() -> Results<User> {
        return database.objects(User.self)
    }
    
    func addUser(object: User)   {
        try! database.write {
            database.add(object, update: true)
        }
    }
    
    func deleteAll()  {
        try! database.write {
            database.deleteAll()
        }
    }
}
