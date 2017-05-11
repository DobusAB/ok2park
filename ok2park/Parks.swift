//
//  Parks.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-05-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import Foundation
import MapKit
import Contacts


class Parks: NSObject, MKAnnotation {

    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let pay_time: String
    let zones: String
    let background_image: String
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, pay_time: String, zones: String, background_image: String) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.pay_time = pay_time
        self.zones = zones
        self.background_image = background_image
        
        super.init()
    }
    
    var subname: String {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subname]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    func pinTintColor() -> UIColor  {
        switch discipline {
        case "Sculpture", "Plaque":
            return MKPinAnnotationView.redPinColor()
        case "Mural", "Monument":
            return MKPinAnnotationView.purplePinColor()
        default:
            return MKPinAnnotationView.greenPinColor()
        }
    }

    
}
