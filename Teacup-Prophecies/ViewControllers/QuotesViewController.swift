//
//  QuotesViewController.swift
//  Teacup-Prophecies
//
//  Created by Jim Sadler on 6/11/17.
//  Copyright © 2017 JS Development. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FirebaseAuth
import FBSDKCoreKit

class QuotesViewController: UIViewController {
    
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    
    var quotes : [Quote] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("quotes").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let quote = Quote()
            quote.quote = (snapshot.value! as! NSDictionary)["quote"] as! String
            
            self.quotes.append(quote)
        })

    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        newQuote()
    }
    
   
    @IBAction func didTappedLogout(_ sender: Any) {
        // sign user out of firebase
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        // sign user out of Facebook
        FBSDKAccessToken.setCurrent(nil)
        let mainStoryboard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let SignInViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginView")
        
        self.present(SignInViewController, animated: true, completion: nil)
    }
    
    
    func newQuote(){
        let myQuote = quotes[Int(arc4random_uniform(UInt32(quotes.count) ))]
        quoteLabel.text =  myQuote.quote
//        print(myQuote.quoteID)

    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        newQuote()
        
    }
}
