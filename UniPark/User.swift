//
//  User.swift
//  UniPark
//
//  Created by Tony Vazgar on 3/26/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import Foundation

class User {
    /*
     *Aqui va el código de la clase Location
     */
    var id_user: String
    var password: String
    
    
    init(_ id: String, _ pass: String) {
        id_user = id
        password = pass
    }
    
}
