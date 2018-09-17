//
//  MapTableViewCell.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {
    
    var mapView: MKMapView = MKMapView()
    let annotation = MKPointAnnotation()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        self.contentView.addSubview(self.mapView)
    }
    
    override func layoutSubviews() {
        self.mapView.frame = self.contentView.bounds
    }
    
    func updateViewWithInfo(_ delivery: Delivery) {
        // add annotation on the map
        let location = delivery.location?.anyObject() as? Location // will always return 1
        self.annotation.title = location?.address
        if let latitude = location?.lat, let longitude = location?.long {
            self.annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: latitude)!, longitude: CLLocationDegrees(exactly: longitude)!)
            self.mapView.centerCoordinate = self.annotation.coordinate
        }
        self.mapView.addAnnotation(self.annotation)
    }
}
