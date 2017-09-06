//
//  ViewController.swift
//  SnapchatClone
//
//  Created by gina iliff on 8/31/17.
//  Copyright © 2017 gina iliff. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var topButton: UIButton!
    
    @IBOutlet weak var bottomButton: UIButton!
    
    var loginMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func topTapped(_ sender: Any) {
        
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if loginMode {
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                        }
                    })
                    
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            if let user = user {
                                Database.database().reference().child("users").child(user.uid).child("email").setValue(email)
                                self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                            }
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if loginMode {
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Login", for: .normal)
            loginMode = false
            
        } else {
            topButton.setTitle("Login", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            loginMode = true
        }
    }
    
    // Hide keyboard when user touches outside text box
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

