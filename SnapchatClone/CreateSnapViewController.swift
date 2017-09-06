//
//  CreateSnapViewController.swift
//  SnapchatClone
//
//  Created by gina iliff on 9/5/17.
//  Copyright © 2017 gina iliff. All rights reserved.
//

import UIKit
import FirebaseStorage

class CreateSnapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var snapDescriptionTextField: UITextField!
    
    @IBOutlet weak var snapImage: UIImageView!
    
    var imageName = "\(NSUUID().uuidString).jpeg"
    var imageURL = ""
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        self.snapDescriptionTextField.delegate = self
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            snapImage.image = chosenImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let imageFolder = Storage.storage().reference().child("images")
    
        if let image = snapImage.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                imageFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error)
                    } else {
                        
                        if let imageURL = metadata?.downloadURL()?.absoluteString {
                            self.imageURL = imageURL
                            
                            self.performSegue(withIdentifier: "addImageToSelectUser", sender: nil)
                        }
                    }
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        snapDescriptionTextField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectTVC = segue.destination as? SelectUserTableViewController {
            selectTVC.imageURL = imageURL
            selectTVC.imageName = imageName
            if let message = snapDescriptionTextField.text {
                selectTVC.message = message
            }
        }
    }

}
