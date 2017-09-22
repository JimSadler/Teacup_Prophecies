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
import FBSDKLoginKit
import FBSDKShareKit

class SignInViewController: UIViewController, FBSDKLoginButtonDelegate {
    let loginButton = FBSDKLoginButton()
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        self.loginButton.isHidden = true
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is signed on
                // move ther user to the quotes view controller
                //                let mainStoryboard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                //                let QuotesViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "QuoteView")
                //
                //                self.present(QuotesViewController, animated: true, completion: nil)
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
                
            } else {
                //no user is signed in.
                // show the user the login button
                self.view.addSubview(self.loginButton)
                self.loginButton.frame = CGRect(x: 16, y: 350, width: self.view.frame.width - 32, height: 50)
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.loginButton.delegate = self
                
                self.loginButton.isHidden = false
            }
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        //        let loginButton = FBSDKLoginButton()
        
        
        
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out of Facebook.")
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successfully logged in with Facebook...")
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            print("User logged in...")
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
            
            
        }
        
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
    
    //    func goToNavigation() {
    //        // Creating a navigation controller with MainMenuViewController at the root of the navigation stack.
    //        let navController = UINavigationController(rootViewController: QuotesViewController())
    //        self.present(navController, animated:true, completion: nil)
    //    }
    //    func checkLogIn() {
    //        if (FBSDKAccessToken.current() != nil) {
    //            // User is already logged in, do work such as go to next view controller.
    //            self.goToNavigation()
    //        }
    //
    //    }
}

