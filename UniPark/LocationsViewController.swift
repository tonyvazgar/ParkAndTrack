//
//  LocationsViewController.swift
//  UniPark
//
//  Created by Tony Vazgar on 5/17/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import UIKit

class LocationsViewController: UITableViewController{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func initializeView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 2
    }
    
    private func addLocationsFromDataBase(){
        var indexPath: IndexPath
        for ip in 0..<Model.locations.count {
            
            indexPath = IndexPath(row: ip, section: 0)
            //Insert this new row into the table view, with animation
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        Model.selectAllLocations()
        addLocationsFromDataBase()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        tableView.reloadData()
        Model.selectAllLocations()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("llegandoaaaaa")
        switch segue.identifier {
        case "map"?:
            //Figure out wich row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let item = Model.locations[row]
                let detailViewController = segue.destination as! DetailMapViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        Model.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let size = Model.locations.count
        return size
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: TableViewCell
        var item: Location
        
        cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! TableViewCell
        
        item = Model.locations[indexPath.row]
        
        cell.latitudLabel.text  = "Latitud: \(item.latitud)"
        cell.longitudLabel.text = "Longitud: \(item.longitud)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        var item: Location
        var tittle: String
        var alertController: UIAlertController
        var cancelAction: UIAlertAction
//        var deleteAction: UIAlertAction

        //If this table view is asking to commit a delete command...

        if editingStyle == UITableViewCell.EditingStyle.delete {
            item = Model.locations[indexPath.row]
            tittle = "Borrar \(item.longitud)?"
            alertController = UIAlertController(title: tittle, message: "De verdad?", preferredStyle: UIAlertController.Style.alert)

            cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil)

            alertController.addAction(cancelAction)
            
//            deleteAction = UIAlertAction(title: "Borrar", style: UIAlertAction.Style.destructive, handler: {
//                (action) -> Void
//                in
//                //Remove the item from the store
//                Model.removeItem(item)
//                //Also remove that row from the table view with animation
////                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
////            })
//            alertController.addAction(deleteAction)

            //Present the alert controller
            present(alertController, animated: true, completion: nil)
        }//end if
    }// end tableView
    
}
