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
    
    
    @IBOutlet weak var addButton: UIButton!
    //@IBOutlet weak var quoteLabel: UITextView!
    
    @IBOutlet weak var quoteLabel: UITextView!
    var quotes : [Quote] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("quotes").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let quote = Quote()
            quote.quote = (snapshot.value! as! NSDictionary)["quote"] as! String
            
            self.quotes.append(quote)
        })
        //UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.quoteLabel.text);
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
//     
        newQuote()
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [quoteLabel.text], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
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
    
    func configureButton()
    {
        addButton.layer.cornerRadius = 0.5 * addButton.bounds.size.width
        addButton.layer.borderColor = UIColor(red:242.0/255.0, green:214.0/255.0, blue:81.0/255.0, alpha:1).cgColor as CGColor
        addButton.layer.borderWidth = 2.0
        addButton.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        configureButton()
    }
    
    
    func newQuote(){
        let myQuote = quotes[Int(arc4random_uniform(UInt32(quotes.count) ))]
        quoteLabel.text =  myQuote.quote
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.quoteLabel.text);
        
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        newQuote()
        
    }
}

