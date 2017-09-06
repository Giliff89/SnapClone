//
//  SelectUserTableViewController.swift
//  SnapchatClone
//
//  Created by gina iliff on 9/5/17.
//  Copyright © 2017 gina iliff. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserTableViewController: UITableViewController {
    
    var emails : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let userDictionary = snapshot.value as? NSDictionary {
                if let email = userDictionary["email"] as? String {
                    self.emails.append(email)
                    self.tableView.reloadData()
                }
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = emails[indexPath.row]

        return cell
    }
}
