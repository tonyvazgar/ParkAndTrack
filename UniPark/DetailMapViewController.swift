//
//  DetailMapViewController.swift
//  UniPark
//
//  Created by Tony Vazgar on 5/18/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import UIKit
import MapKit


class DetailMapViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyBoard))
        
        self.view.addGestureRecognizer(tap)
        print("Llegando al mapa")
        // Do any additional setup after loading the view.
    }
    
    @objc func hideKeyBoard () {
        self.view.endEditing(true)
    }
    
    var item: Location! {
        didSet {
            navigationItem.title = "\(item.latitud), \(item.longitud)"
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        return dateFormatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var lat = Double(item.latitud)!
        var lon = Double(item.longitud)!
        print("\(lat)-----------.\(lon)")
        let initialLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let pin = MKPointAnnotation()
        pin.coordinate = initialLocation
        pin.title = "You was here!"
        map.addAnnotation(pin)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Clear first responser
        view .endEditing(true)
        
        //      Actualiza el item
        //      The nil-coalescing operator (a ?? b) unwraps an optional nameField.text
        //      if it contains a value, or returns a default value "" if is a nil.
//        item.name = nameField.text ?? ""
//        item.serialNumber = serialNumberField.text
    }
    
    
    //   textFieldShouldTeturn asks the delegate if the delegate if the text field
    //  should process the pressing of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
