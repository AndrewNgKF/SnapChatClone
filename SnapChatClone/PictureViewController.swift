//
//  PictureViewController.swift
//  SnapChatClone
//
//  Created by IMAC on 24/8/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .photoLibrary //change to camera, only for debgging purposes.
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    @IBAction func nextTapped(_ sender: AnyObject) {
        
        nextBtn.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)
        
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData!, metadata: nil) { (metadata, error) in
            
            print("We tried to upload")
            if error != nil {
                print("We had an error \(error)")
                
            } else {
                
                print(metadata?.downloadURL())
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)

            }
        }
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageUrl = sender as! String
        nextVC.descrip = descriptionTextField.text!
        
    }
    
}
