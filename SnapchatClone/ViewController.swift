//
//  ViewController.swift
//  SnapchatClone
//
//  Created by gina iliff on 8/31/17.
//  Copyright © 2017 gina iliff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Hide keyboard when user touches outside text box
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Hide keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mealDescriptionText.resignFirstResponder()
        return true
    }


}

