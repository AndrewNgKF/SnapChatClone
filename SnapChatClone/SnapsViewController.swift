//
//  SnapsViewController.swift
//  SnapChatClone
//
//  Created by IMAC on 24/8/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func logoutTapped(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
