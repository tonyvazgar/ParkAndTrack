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
        carLocation = mapView.userLocation.coordinate  //CLLocationCoordinate2D(latitude: 19.006680, longitude: -98.267865)//
        saveLocation(latitude: carLocation!.latitude, longitude: carLocation!.longitude)
        let pin = MKPointAnnotation()
        pin.coordinate = carLocation!
        pin.title = "Your 🚘 is here!"
        print(carLocation!)
        mapView.addAnnotation(pin)
    }
    
    func askLocationDB() {
        print("Se ha invocado este método")
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        if let carlocation = carLocation {
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: carlocation))
            
//            request.requestsAlternateRoutes = true
            request.transportType = .automobile
            
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
        } else {
            let alert = UIAlertController(title: "Error while finding your 🚘", message: "You must first save your location", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func saveLocation(latitude: Double, longitude: Double) {
        let latitud = String(format:"%f", latitude)
        let longitu = String(format:"%f", longitude)
        print(type(of: latitud))
        print(type(of: longitu))
        Model.insertIntoLocation(latitud: latitud, longitud: longitu)
    }
    
    // set initial location in UDLAP
    let initialLocation = CLLocation(latitude: 18.951662, longitude: -98.285960)
    let regionRadius: CLLocationDistance = 5000
    
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
        
        Model.crearDB("parkandtrack")
        Model.openDB()
        Model.execute("CREATE TABLE IF NOT EXISTS User (id TEXT, password TEXT)")
        Model.execute("CREATE TABLE IF NOT EXISTS Location (latitud DOUBLE, longitud DOUBLE)")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 2.0
        return renderer
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
}
