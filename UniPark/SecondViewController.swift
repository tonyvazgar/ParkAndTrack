//
//  SecondViewController.swift
//  UniPark
//
//  Created by Tony Vazgar on 2/17/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController{

    
    func obtenerUbicaciones(){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Model.selectAllLocations()
    }
}
