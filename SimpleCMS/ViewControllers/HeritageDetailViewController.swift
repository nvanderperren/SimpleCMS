//
//  HeritageDetailViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 10/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageDetailViewController: UITableViewController, UITextFieldDelegate {
    
    var heritageId: String?
    var heritageName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        self.tableView.allowsSelection = false
        self.tableView.allowsSelectionDuringEditing = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
