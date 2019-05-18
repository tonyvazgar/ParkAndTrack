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
    static var locations: Array<Location> = []
    static var users = Array<User>()
    static var dbURL: URL? = nil
    
    public static func crearDB(_ aName: String){
        Model.dbURL = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        Model.dbURL = Model.dbURL?.appendingPathComponent(aName + ".sqlite")
        print("La BDDs se creó en: \(Model.dbURL!)")
        
    }
    
    public static func openDB(){
        if (sqlite3_open(Model.dbURL!.path, &Model.dbPointer) != SQLITE_OK) {
            print("Error abriendo la BDDs")
        }else{
            print("BDDs abierta!")
        }
    }
    
    public static func execute(_ aStatement: String){
        if(sqlite3_exec(Model.dbPointer, aStatement, nil, nil, nil) != SQLITE_OK){
            print("error excecuting SQL statement: \(String(cString: sqlite3_errmsg(Model.dbPointer)!))")
        }else{
//            print("SQL statement excecuted: \(aStatement)")
        }
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
    
    public static func insertInto(name: String){
        let query = "INSERT INTO User (id) VALUES (?)"
        print("La query es --> ", query)
        var errMessage: String
        if querylista(query: query) {
            if sqlite3_bind_text(statementPointer, 1, name, -1, nil) != SQLITE_OK{
                errMessage = String(cString: sqlite3_errmsg(dbPointer)!)
                print("Faiulure binding latitud: \(errMessage)")
                return
            }else{
                //                print("Binding name value.... OKI...")
            }
            if sqlite3_step(statementPointer) != SQLITE_DONE{
                errMessage = String(cString: sqlite3_errmsg(dbPointer)!)
                print("Faiulure inserting record: \(errMessage)")
                return
            }else{
                print("Record inserted :)")
            }
        }
    }
    
    public static func insertIntoLocation(latitud: String, longitud: String){
        let query = "INSERT INTO Location (latitud, longitud) VALUES (?,?)"
        print("La query es --> ", query)
        var errMessage: String
        if querylista(query: query) {
            if sqlite3_bind_text(statementPointer, 1, latitud, -1, nil) != SQLITE_OK{
                errMessage = String(cString: sqlite3_errmsg(dbPointer)!)
                print("Faiulure binding latitud: \(errMessage)")
                return
            }else{
//                print("Binding name value.... OKI...")
            }
            if sqlite3_bind_double(statementPointer, 2, (longitud as NSString).doubleValue) != SQLITE_OK {
                errMessage = String(cString: sqlite3_errmsg(dbPointer)!)
                print("Failure binding longitud: \(errMessage)")
                return
            }
            if sqlite3_step(statementPointer) != SQLITE_DONE{
                errMessage = String(cString: sqlite3_errmsg(dbPointer)!)
                print("Faiulure inserting record: \(errMessage)")
                return
            }else{
                print("Record inserted :)")
            }
        }
    }
    
    private static func querylista(query: String) -> Bool {
        var queryIsPrepared = false
        if sqlite3_prepare(dbPointer, query, -1, &statementPointer, nil) != SQLITE_OK{
            let errorMessage = String(cString: sqlite3_errmsg(dbPointer)!)
            print("Error preparing query: " + query)
            print(errorMessage)
        } else{
            queryIsPrepared = true
        }
        return queryIsPrepared
    }
    
    public static func selectAllLocations(){
        let query = "SELECT * FROM Location"
        if querylista(query: query){
            locations = getResultSet()
        }
        for l in locations{
            print("\(l.latitud)|\(l.longitud)")
        }
    }
    
    static func getResultSet() -> Array<Location>{
        var resultSet :Array<Location>
        var latitud : String
        var longitud: String
        
        resultSet = []
        
        while(sqlite3_step(statementPointer) == SQLITE_ROW){
            //id = sqlite3_column_int(statementPointer, 0)
            latitud  = String(cString: sqlite3_column_text(statementPointer, 0))
            longitud = String(cString: sqlite3_column_text(statementPointer, 1))
            resultSet.append(Location(latitud, longitud))
        }//end while
        return resultSet
    }
    
    public static func moveItem(fromIndex: Int, toIndex: Int){
        //Haciendo un swap en el arreglo de Items
        var movedItem: Location
        if fromIndex != toIndex {
            movedItem = locations[fromIndex]
            locations.remove(at: fromIndex)
            locations.insert(movedItem, at: toIndex)
        }
    }
}
extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
