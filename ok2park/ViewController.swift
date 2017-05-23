//
//  ViewController.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON
import Firebase

//import KCFloatingActionButton

class ViewController: UIViewController, CLLocationManagerDelegate {
   
    @IBOutlet weak var mapView: MKMapView!
    var actionButton: ActionButton!
    var dataToSend: [String: Any] = [:]
    var regionRadius: CLLocationDistance = 1000
    
    var locationManager = CLLocationManager()
    var regionsToMonitor = [CLCircularRegion]()

    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            
        }
    }
    
    
    /* func loadInitialData() {
        // 1
        let fileName = Bundle.main.path(forResource: "parks", ofType: "json");
        var data: Data?
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
        } catch _ {
            data = nil
        }
        var jsonObject: Any? = nil
        if let data = data {
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
            } catch _ {
                jsonObject = nil
            }
        }
        
        if let value = jsonObject {
                
            let json = JSON(value)
            let data = json["data"]
            
            for (_, item) in data {
                let parks = Parks(title: item["title"].stringValue,
                                  locationName: item["locationName"].stringValue,
                                  discipline: item["discipline"].stringValue,
                                  coordinate: CLLocationCoordinate2D(latitude: item["lat"].doubleValue, longitude: item["long"].doubleValue),
                                  pay_time: item["pay_time"].stringValue,
                                  zones: item["zone"].stringValue,
                                  background_image: item["background_image"].stringValue,
                                  park_sign: item["park_sign"].stringValue,
                                  icon_image: "location_icon"
                                  
                )
                mapView.addAnnotation(parks)
            }
        }
    }*/

    func getdata() {
        let ref = FIRDatabase.database().reference()
        ref.child("data/locations").observe(FIRDataEventType.value, with: { (snapshot) in
            //let dict = snapshot.value as? [String : AnyObject] ?? [:]
            
            if let value = snapshot.value as? NSArray {
                
                let allAnnotations = self.mapView.annotations
                self.mapView.removeAnnotations(allAnnotations)
                let json = JSON(value)
                var i = 0;
                for (_, item) in json {
                    var reg_nr = "";
                    if(item["reg_nr"].exists())
                    {
                        reg_nr = item["reg_nr"].stringValue
                    }
                  let parks = Parks(title: item["title"].stringValue,
                                      locationName: item["locationName"].stringValue,
                                      discipline: item["discipline"].stringValue,
                                      coordinate: CLLocationCoordinate2D(latitude: item["lat"].doubleValue, longitude: item["long"].doubleValue),
                                      pay_time: item["pay_time"].stringValue,
                                      zones: item["zone"].stringValue,
                                      background_image: item["background_image"].stringValue,
                                      park_sign: item["park_sign"].stringValue,
                                      icon_image: "location_icon",
                                      id: i,
                                      reg_nr: reg_nr
                        
                    )
                    
                    self.mapView.addAnnotation(parks)
                    i += 1;
                }

                
            }
        })
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if actionButton.active == true {
            actionButton.toggleMenu()
        }
        self.getdata()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //1
        if locations.count > 0 {
            let location = locations.last!
            print("Accuracy: \(location.horizontalAccuracy)")
            
            //2
            if location.horizontalAccuracy < 100 {
                //3
                manager.stopUpdatingLocation()
                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
                //mapView.region = region
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // checkLocationAuthorizationStatus()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
       
        
        // loadInitialData()
        
        
        
        // let initialLocation = CLLocation(latitude: 56.6743748, longitude: 12.857788400000004)
        
        
        
        //centerMapOnLocation(location: initialLocation)
        
        
        
        actionButton = ActionButton(attachedToView: self.view, items: [])
        
        let PeopleIcon = UIImage(named: "car_icon")!
        
        // let ticketIcon = UIImage(named: "ticket_icon")!
        
        let requestOffer = ActionButtonItem(title: "Gå till mina fordon", image: PeopleIcon)
        
        // let goToTicket = ActionButtonItem(title: "Biljetter", image: ticketIcon)
        
        requestOffer.action = { item in
            self.performSegue(withIdentifier: "ShowMinafordonSegue", sender: self)
        }
        
        /*goToTicket.action = {item in
            self.performSegue(withIdentifier: "ShowNyparkeringSegue", sender: self)
            
        }*/
        
        actionButton = ActionButton(attachedToView: self.view, items: [requestOffer ])

        
        actionButton.action = { button in button.toggleMenu() }
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Parks
        // let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        dataToSend = [
            "title": location.title!,
            "locationName": location.locationName,
            "discipline": location.discipline,
            "coordinate": location.coordinate,
            "zone": location.zones,
            "pay_time": location.pay_time,
            "background_image": location.background_image,
            "park_sign": location.park_sign,
            "id": location.id
            ] as [String : Any];
        performSegue(withIdentifier: "ShowNyparkeringSegue", sender: self)
        //print(location)
        // location.mapItem().openInMaps(launchOptions: launchOptions)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNyparkeringSegue"
        {
            //let indexPath = self.tableView.indexPath(for: sender as! teamhalsaTableViewCell)
            let controller = segue.destination as! NyparkeringViewController
            
            let jsonToSend = self.dataToSend
             controller.item = jsonToSend
            
            
            
            //controller.offer = offer
        }

    }
    
}

