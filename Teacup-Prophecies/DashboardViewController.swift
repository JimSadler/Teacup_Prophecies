//
//  DashboardViewController.swift
//  Teacup-Prophecies
//
//  Created by Jim Sadler on 6/11/17.
//  Copyright © 2017 JS Development. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
