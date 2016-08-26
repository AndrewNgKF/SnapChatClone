//
//  SnapsViewController.swift
//  SnapChatClone
//
//  Created by IMAC on 24/8/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []
    
    var snap = Snap()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        

        //gets the deeper file directory in firebase database
        
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in

            
            let snap = Snap()
            
            snap.imageURL = snapshot.childSnapshot(forPath: "imageUrl").value as! String
            snap.from = snapshot.childSnapshot(forPath: "from").value as! String
            snap.descrip = snapshot.childSnapshot(forPath: "description").value as! String
 
            print(snapshot)
            
            self.snaps.append(snap)
            self.tableView.reloadData()
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        
        
        cell.textLabel?.text = snap.descrip
        return cell
    }
   
    @IBAction func logoutTapped(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            
            nextVC.snap = sender as! Snap
        }
        
        
    }
    
    
}
