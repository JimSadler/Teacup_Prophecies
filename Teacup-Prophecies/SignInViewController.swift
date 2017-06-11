//
//  SignInViewController.swift
//  Teacup-Prophecies
//
//  Created by Jim Sadler on 6/11/17.
//  Copyright © 2017 JS Development. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  

    @IBAction func signInTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print ("Hey we have an error:\(String(describing: error))")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print ("Hey we have an error:\(String(describing: error))")
                        
                    } else {
                        print("Created user successfully")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
                
            } else {
                print("signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
                
            }
        }
    }
    
}

