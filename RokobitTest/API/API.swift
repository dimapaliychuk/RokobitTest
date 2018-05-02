//
//  API.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//


import Foundation
import Alamofire


class API: BaseService {
    
    static let shared = API()
    
    func getUser(completion: @escaping (_ result: Result<UserResponse>)->Void) {
        executeRequest(
            path: "users/2",
            method: .get,
            encoding: URLEncoding.default,
            parameters: [:],
            completionHandler: completion
        )
    }
}
