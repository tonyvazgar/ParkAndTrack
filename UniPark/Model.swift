//
//  Model.swift
//  UniPark
//
//  Created by Tony Vazgar on 3/26/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import SQLite3
import UIKit

public class Model {
    
    static var dbPointer: OpaquePointer? = nil
    static var statementPointer: OpaquePointer? = nil
    static var locations = Array<Location>()
    static var users = Array<User>()
    static var dbURL: URL? = nil
    
    public static func crearDB(_ aName: String){
        
    }
    
    public static func openDB(){
        
    }
    
    public static func execute(_ aStatement: String){
        
    }
    
    static func getResultSetLocations() -> Array<Location> {
        var resultSet : Array<Location>
        resultSet = []
        return resultSet
    }
    
    static func getResultSetUsers() -> Array<User> {
        var resultSet : Array<User>
        resultSet = []
        return resultSet
    }
    
    public static func insertInto(name: String, pass: String){
     
        
    }
    
}
