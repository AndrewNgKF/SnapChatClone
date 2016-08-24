//
//  SignInViewController.swift
//  SnapChatClone
//
//  Created by IMAC on 24/8/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func signInTapped(_ sender: AnyObject) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("Have an error! \(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    
                    print("We tried to create user")
                    
                    if error != nil {
                        print("Create Email ID error \(error)")
                    } else {
                        print("created user successfully")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                    
                })
            } else {
                print("Sign in successful yay!")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
            
        })
        
    }

   
    
    
    

}
