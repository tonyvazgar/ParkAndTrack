//
//  FirstViewController.swift
//  UniPark
//
//  Created by Tony Vazgar on 2/17/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var manager = CLLocationManager()
    var carLocation: CLLocationCoordinate2D?
    
    
    @IBAction func dropButton(_ sender: Any) {
        obtenerUbicacionDevice()
    }
    
    @IBAction func findButton(_ sender: Any) {
        askLocationDB()
    }
    
    func obtenerUbicacionDevice() {
        carLocation = mapView.userLocation.coordinate
        saveLocation(latitude: carLocation!.latitude, longitude: carLocation!.longitude)
        let pin = MKPointAnnotation()
        pin.coordinate = carLocation!
        pin.title = "Your 🚘 is here!"
        print(carLocation!)
        print(type(of: carLocation!.latitude))
        print(type(of: carLocation!.longitude))
        mapView.addAnnotation(pin)
    }
    
    func askLocationDB() {
        print("Se ha invocado este método")
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: carLocation!))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate{
            [unowned self] response, error
            in
            guard let unwrappedResponse = response
                else {
                    return
            }
            for route in unwrappedResponse.routes{
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func saveLocation(latitude: Double, longitude: Double) {
        var latitude = String(latitude)
        var longitud = String(longitude)
        //Aqui se va a hacer el insert a la base de datos
        print(type(of: latitude), "--",longitude)
        
    }
    
    // set initial location in UDLAP
    let initialLocation = CLLocation(latitude: 19.0540, longitude: -98.2822)
    let regionRadius: CLLocationDistance = 500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        manager.delegate = self
        if manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)){
            manager.requestWhenInUseAuthorization()
        }
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}
