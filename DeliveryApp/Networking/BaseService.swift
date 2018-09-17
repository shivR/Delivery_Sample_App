//
//  BaseService.swift
//  DeliveryApp
//
//  Created by Shiv V on 15/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import Foundation
import UIKit.UIImage

private let BaseUrl = "http://localhost:8080/"

enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
}

struct RequestModal {
    var method: HTTPMethod
    var path: String
    var parameters: [String: AnyObject]?
    
    init() {
        method = .GET
        path = ""
        parameters = nil
    }
    
    func apiURL() -> String {
        return BaseUrl + self.path
    }
    
    func params() -> [String: AnyObject]? {
        return self.parameters
    }
}

class BaseService: NSObject {
    // set up the session
    let session = URLSession(configuration: URLSessionConfiguration.default)

    func callWebServiceAlamofire(_ request: RequestModal,
                                 success:@escaping ((_ responseObject: Any?) -> Void),
                                 failure:@escaping ((_ error: Error?) -> Void)) {
        
        
        var urlStr: String = request.apiURL()
        if let params = request.params(), request.method == .GET {
            urlStr = urlStr.appendingQueryItems(params)
        }
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        // make the request
        let task = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let responseData = data {
                if let responseJson = try? JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableLeaves) {
                    success(responseJson)
                } else {
                    failure(error)
                }
            } else {
                failure(error)
            }
        })
        task.resume()
    }
    
    func downloadImageWithUrl(_ urlStr: String,
                                 success:@escaping ((_ responseObject: UIImage) -> Void),
                                 failure:@escaping ((_ error: Error?) -> Void)) {
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        // make the request
        let task = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let responseData = data, let image = UIImage(data: responseData) {
                success(image)
            } else {
                failure(error)
            }
        })
        task.resume()
    }
}

extension String {
    mutating func appendingQueryItems(_ contentsOf: [String: AnyObject]) -> String {
        self.append("?")
        for (key, value) in contentsOf {
            self.append(key + "=" + "\(value)")
            self.append("&")
        }
        self = String(self.dropLast())
        return self
    }
}
