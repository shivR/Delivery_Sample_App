//
//  ConnectionManager.swift
//  DeliveryApp
//
//  Created by Shiv V on 15/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import UIKit

private let kDeliveries = "deliveries"

class ConnectionManager: BaseService {
    
    static let instance = ConnectionManager()
    
    func fetchDeliveries(offset: Int, limit: Int, success: @escaping ((_ response: Any?) -> Void), failure: @escaping ((_ error: Error?) -> Void)) {
        var request = RequestModal()
        request.parameters = ["offset": offset,
                              "limit": limit] as [String: AnyObject]
        request.path = kDeliveries
        callWebServiceAlamofire(request, success: success, failure: failure)
    }
}
