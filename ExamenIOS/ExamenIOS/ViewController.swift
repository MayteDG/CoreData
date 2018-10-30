//
//  ViewController.swift
//  ExamenIOS
//
//  Created by Mayte Dominguez on 10/29/18.
//  Copyright © 2018 Mayte Dominguez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,  CLLocationManagerDelegate {

    
    @IBOutlet weak var txtLatitud: UITextField!
    @IBOutlet weak var txtLongitud: UITextField!
    @IBOutlet weak var map: MKMapView!
    var LugarMap = CLLocationManager()
    
    var latitud : Double = 0.0
    var longitud : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LugarMap.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            LugarMap.delegate = self
            LugarMap.desiredAccuracy = kCLLocationAccuracyBest
            LugarMap.startUpdatingLocation()
        }
    }
    

    func pin (lati : Double, longi : Double) {
         // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(lati, longi);
        myAnnotation.title = "Current location"
        self.map.addAnnotation(myAnnotation)
        
        let center = CLLocationCoordinate2D(latitude: latitud, longitude: longitud )
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.map.setRegion(region, animated: true)
    }
    
    
    @IBAction func btnPin(_ sender: Any) {
        latitud = Double (txtLatitud.text!)!
        longitud = Double (txtLongitud.text!)!
        pin(lati: latitud, longi: longitud)
    }
    
    
    
    
    
}

