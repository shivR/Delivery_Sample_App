//
//  Location+CoreDataProperties.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var address: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var delivery: Delivery?

}
