//
//  Location.swift
//  UniPark
//
//  Created by Tony Vazgar on 3/26/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import Foundation

class Location:NSObject {
    /*
     *Aqui va el código de la clase Location
     */
    var latitud: String
    var longitud: String
    //var id_user: String
    
    
    init(_ lat: String, _ long: String) {
        //id_user = id
        latitud = lat
        longitud = long
    }
}
