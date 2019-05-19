//
//  LoginViewController.swift
//  UniPark
//
//  Created by Tony Vazgar on 2/18/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    static var username: String = ""
    
    @IBAction func singInButton(_ sender: Any) {
        let name = userTextfield.text!
        loginDB(user: name)
    }
    
    func loginDB(user: String) -> Bool{
        var exists: Bool
        exists = true
        Model.insertInto(name: user)
        LoginViewController.username = user
        return exists
    }
    public func getUsername() -> String{
        return userTextfield.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        
        Model.crearDB("parkandtrack")
        Model.openDB()
        Model.execute("CREATE TABLE IF NOT EXISTS User (id TEXT)")
//        Model.execute("DROP TABLE Location")
        Model.execute("CREATE TABLE IF NOT EXISTS Location (latitud TEXT, longitud TEXT)")
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
