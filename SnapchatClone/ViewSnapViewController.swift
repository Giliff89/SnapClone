//
//  ViewSnapViewController.swift
//  SnapchatClone
//
//  Created by gina iliff on 9/6/17.
//  Copyright © 2017 gina iliff. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var snapImageView: UIImageView!
    
    @IBOutlet weak var snapMessageLabel: UILabel!
    
    var snapshot : DataSnapshot?
    var imageName = ""
    var snapID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snapshot = snapshot {
            if let snapDictionary = snapshot.value as? NSDictionary {
                if let imageName = snapDictionary["imageName"] as? String {
                    if let imageURL = snapDictionary["imageURL"] as? String {
                        if let message = snapDictionary["message"] as? String {
                            
                            snapMessageLabel.text = message
                            
                            if let url = URL(string: imageURL) {
                                
                                snapImageView.sd_setImage(with: url)
                            }
                            
                            self.imageName = imageName
                            
                            snapID = snapshot.key
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).child("snaps").child(snapID).removeValue()
            
            Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
        }
    }
}
