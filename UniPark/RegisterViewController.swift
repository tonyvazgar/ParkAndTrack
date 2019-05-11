//
//  RegisterViewController.swift
//  UniPark
//
//  Created by Tony Vazgar on 2/18/19.
//  Copyright © 2019 Tony Vazgar. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBAction func goButton(_ sender: Any) {
        var username: String
        var password: String
        
        username = userTextField.text!
        password = passTextField.text!
        
        register(user: username, pass: password)
    }
    
    func register(user: String, pass: String){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
    }
}
