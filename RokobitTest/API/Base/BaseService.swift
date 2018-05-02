//
//  BaseService.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Alamofire


class BaseService {
    
    fileprivate static var manager: Alamofire.SessionManager = {
        return Alamofire.SessionManager.default
    }()
    
    fileprivate func url(path: String) -> String {
        return Constants.baseURL + path
    }
    
    func executeRequest<T: Codable>(
        path: String = "",
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = JSONEncoding.default,
        parameters: Parameters?,
        headers: HTTPHeaders? = nil,
        completionHandler: @escaping (_ result: Result<T>) -> Void
        ) {
        
        let urlString = url(path: path)
        
        executeRequest(
            urlString: urlString,
            method: method,
            encoding: encoding,
            parameters: parameters,
            headers: headers,
            completionHandler: completionHandler
        )
    }
    
    func executeRequest<T: Codable>(
        urlString: String,
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = JSONEncoding.default,
        parameters: Parameters?,
        headers: HTTPHeaders? = nil,
        completionHandler: @escaping (_ result: Result<T>) -> Void
        ) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var jsonDataResponse: DataResponse<Any>?
        
        _ = BaseService.manager.request(
            urlString,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
            ).responseJSON(completionHandler: { dataResponse in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                jsonDataResponse = dataResponse
            }).responseCodable { (result: Result<T>) in
                
                self.logRequest(
                    urlString: urlString,
                    method: method,
                    headers: headers,
                    parameters: parameters,
                    error: result.error,
                    dataResponse: jsonDataResponse
                )
                
            completionHandler(result)
        }
    }
    
    private func logRequest(urlString: String, method: HTTPMethod, headers: HTTPHeaders?, parameters: Parameters?, error: Error?, dataResponse: DataResponse<Any>?) {
        
        print(
            "\n====================================" +
                "\nrequest: url: \(urlString)" +
                "\nmethod: \(method)" +
                "\nheaders: \(String(describing: headers))" +
                "\nparameters: \(String(describing: parameters))" +
                "\n---------------------------------" +
                "\ncode: \(String(describing: dataResponse?.response?.statusCode))" +
                "\nerror: \(String(describing: error))" +
                //                "\nerrorDescription: \(error ?? "")" +
                "\nresponse: \(String(describing: dataResponse?.result.value))" +
            "\n====================================\n"
        )
    }
}

