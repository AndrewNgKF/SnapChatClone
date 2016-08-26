//
//  ViewSnapViewController.swift
//  SnapChatClone
//
//  Created by IMAC on 24/8/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit
import SDWebImage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

   

}
