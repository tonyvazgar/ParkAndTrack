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
    
    @IBAction func singInButton(_ sender: Any) {
        if(loginDB(user: userTextfield.text!, pass: passwordTextField.text!)) {
            
        }else{
            
        }
    }
    
    func loginDB(user: String, pass: String) -> Bool{
        var exists: Bool
        exists = false
        /*
         * Código para autenticar con BDs
         */
        return exists
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround() 
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
