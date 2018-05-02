//
//  DataRequest+JSONJoy.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Alamofire


extension DataRequest {
    
    func responseCodable<T: Codable>(
        completionHandler: @escaping (Result<T>) -> Void)
        -> Self {
            
            return responseData { dataResponse in
                if let error = dataResponse.error {
                    
                    completionHandler(
                        Result.failure(error)
                    )
                    return
                    
                } else if let data = dataResponse.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let t = try decoder.decode(T.self, from: data)
                        
                        completionHandler(
                            Result.success(t)
                        )
                    } catch {
                        print("error trying to convert data to JSON")
                        print(error)
                        completionHandler(
                            Result.failure(error)
                        )
                    }
                }
            }
    }
}

