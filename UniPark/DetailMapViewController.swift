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
            navigationItem.title = item.latitud
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
        //Actualizar el view
//        nameField.text = item.name
//        serialNumberField.text = item.serialNumber
//        valueField.text = numberFormatter.string(from: NSNumber(value: item.value))
//        dateLabel.text = dateFormatter.string(from: item.dateCreated)
//
//        PONER EL PIN CON LA LOCALIZADA
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
