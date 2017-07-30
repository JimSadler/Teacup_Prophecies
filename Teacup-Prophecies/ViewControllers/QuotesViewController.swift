//
//  QuotesViewController.swift
//  Teacup-Prophecies
//
//  Created by Jim Sadler on 6/11/17.
//  Copyright © 2017 JS Development. All rights reserved.
//

import UIKit
import Firebase

class QuotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var quotes : [Quote] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
//        Database.database().reference().child("quotes/quote\(arc4random_uniform(386))").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
//            print(snapshot)
//
//
//                    let quote = Quote()
//                    quote.quote = (snapshot.value as!NSDictionary)["quote"] as! String
//
//        })
        
        Database.database().reference().child("quotes").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let quote = Quote()
            quote.quote = (snapshot.value! as! NSDictionary)["quote"] as! String
            
            self.quotes.append(quote)
            self.tableView.reloadData()
        })
        
         //Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        //let quote = quotes[indexPath.row]
        let quote =  quotes[Int(arc4random_uniform(UInt32(quotes.count) ))]
        

        cell.textLabel?.text = quote.quote
        
        return cell
    }
    

}
