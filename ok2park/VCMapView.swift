//
//  VCMapView.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-05-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import Foundation

import MapKit

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Parks {
            let identifier = "pin"
            
            var view: MKPinAnnotationView
            /* if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
            } else {
                // 3
                            }*/
            
            var annotationView: MKAnnotationView?
            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            }
            else {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            
            if let annotationView = annotationView {
                // Configure your annotation view here
                annotationView.canShowCallout = true
                if(annotation.reg_nr != "")
                {
                    annotationView.image = UIImage(named: "location_icon_green")
                }else {
                    annotationView.image = UIImage(named: "location_icon_orange")
                }
                
            }
            
            return annotationView
            
            /* view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView

            return view*/
        }
        return nil
    }
}


