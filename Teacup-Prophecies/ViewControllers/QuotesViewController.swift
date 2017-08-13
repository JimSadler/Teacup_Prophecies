//
//  QuotesViewController.swift
//  Teacup-Prophecies
//
//  Created by Jim Sadler on 6/11/17.
//  Copyright © 2017 JS Development. All rights reserved.
//

import UIKit
import Firebase

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
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func newQuote(){
        let myQuote = quotes[Int(arc4random_uniform(UInt32(quotes.count) ))]
        quoteLabel.text =  myQuote.quote
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        newQuote()
        
    }
}
