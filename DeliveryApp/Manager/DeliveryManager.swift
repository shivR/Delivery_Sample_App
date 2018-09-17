//
//  DeliveryManager.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import UIKit
import CoreData

class DeliveryManager: NSObject {
    static let instance = DeliveryManager()
    private let context = AppDelegate.appDelegate.persistentContainer.viewContext

    func fetchDeliveries(offset: Int, limit: Int, success: @escaping ((_ response: [Delivery]) -> Void), failure: @escaping ((_ error: Error?) -> Void)) {
        ConnectionManager.instance.fetchDeliveries(offset: offset, limit: limit, success: {[weak self] (response) in
            guard let strongSelf = self else {
                return
            }
            var deliveries: [Delivery] = []
            if let responseData = response as? [[String: Any]] {
                for deliveryJson in responseData {
                    
                    let delivery = NSEntityDescription.insertNewObject(forEntityName: "Delivery", into: strongSelf.context) as! Delivery
                    delivery.deliveryId = deliveryJson["id"] as? Int64 ?? 0
                    delivery.deliveryDescription = deliveryJson["description"] as? String ?? ""
                    delivery.imageUrl = deliveryJson["imageUrl"] as? String ?? ""
                    
                    if let locationJson = deliveryJson["location"] as? [String: Any] {
                        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: strongSelf.context) as! Location
                        location.lat = locationJson["lat"] as? Double ?? 0.0
                        location.long = locationJson["lng"] as? Double ?? 0.0
                        location.address = locationJson["address"] as? String ?? ""
                        delivery.addToLocation(location)
                        location.delivery = delivery
                    }
                    do {
                        try strongSelf.context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    deliveries.append(delivery)
                }
            }
            
            success(deliveries)
        }, failure: failure)
    }
}
