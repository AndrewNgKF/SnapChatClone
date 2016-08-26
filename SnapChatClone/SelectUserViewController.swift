//
//  SelectUserViewController.swift
//  SnapChatClone
//
//  Created by IMAC on 24/8/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageUrl = ""
    var descrip = ""
    var uuid = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)

            let user = User()
            
            user.email = snapshot.childSnapshot(forPath: "email").value as! String
            user.uid = snapshot.key
 
            print(user.email)
            
            self.users.append(user)
            
            self.tableView.reloadData()
            
        })


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let user = users[indexPath.row]
        
        let snap = ["from": FIRAuth.auth()!.currentUser!.email!, "description": descrip, "imageUrl": imageUrl, "uuid": uuid]
        
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController?.popToRootViewController(animated: true)

    }
    
    
}
