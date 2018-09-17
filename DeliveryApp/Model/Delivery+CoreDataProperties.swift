//
//  Delivery+CoreDataProperties.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//
//

import Foundation
import CoreData


extension Delivery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Delivery> {
        return NSFetchRequest<Delivery>(entityName: "Delivery")
    }

    @NSManaged public var deliveryDescription: String?
    @NSManaged public var deliveryId: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var location: NSSet?

}

// MARK: Generated accessors for location
extension Delivery {

    @objc(addLocationObject:)
    @NSManaged public func addToLocation(_ value: Location)

    @objc(removeLocationObject:)
    @NSManaged public func removeFromLocation(_ value: Location)

    @objc(addLocation:)
    @NSManaged public func addToLocation(_ values: NSSet)

    @objc(removeLocation:)
    @NSManaged public func removeFromLocation(_ values: NSSet)

}
