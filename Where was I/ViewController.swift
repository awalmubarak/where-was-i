//
//  ViewController.swift
//  Where was I
//
//  Created by Mubarak Awal on 17/02/2019.
//  Copyright © 2019 Mubarak Awal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapVIew: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        updateMapAnotation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else{
            print("No Access for location")
            return
        }
        print("location granted")
        mapVIew.showsUserLocation = true
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        let coord = locationManager.location?.coordinate
        if let lat = coord?.latitude{
            if let long = coord?.longitude{
                DataStore().saveLocation(lat: String(lat), long: String(long))
                updateMapAnotation()
            }
        }
        
    }
    
    func updateMapAnotation(){
        if let oldCoords = DataStore().getLastLocation(){
            let oldAnotations = mapVIew.annotations.filter{$0 !== mapVIew.userLocation}
            mapVIew.removeAnnotations(oldAnotations)
            let anotation = MKPointAnnotation()
            anotation.coordinate.latitude = Double(oldCoords.latitude)!
            anotation.coordinate.longitude = Double(oldCoords.longitude)!
            anotation.title = "I was here!"
            anotation.subtitle = "Remember?"
            mapVIew.addAnnotation(anotation)
        }
    }
    

}

